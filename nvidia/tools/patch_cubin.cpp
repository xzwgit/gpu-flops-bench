// patch_cubin.cpp — SM120/121 隐藏格式 cubin 补丁器 + 嵌入文件生成器
// 用法1: patch_cubin <mma_e3m4_ab|mma_e0m3_ab> <file.cubin>
// 用法2: patch_cubin --embed <out.cpp> <name1>=<file1> [name2>=<file2> ...]
// 位语义 (发现: vllm-project/humming):
//   QMMA 0x27a/0x47a: A{78,82,83}/B{79,84,85}: E5M2=001 → E3M4=010
//   OMMA 0x47f: bit78(A)/bit79(B): E2M1=0 → E0M3=1; bit83=2X 对 E0M3 非法
#include <cstdio>
#include <cstdint>
#include <cstring>
#include <fstream>
#include <string>
#include <vector>

static int getbit(const std::vector<uint8_t> &d, size_t o, int n) {
	return (d[o + n / 8] >> (n % 8)) & 1;
}
static void setbit(std::vector<uint8_t> &d, size_t o, int n, int v) {
	if (v) d[o + n / 8] |= 1u << (n % 8);
	else d[o + n / 8] &= ~(1u << (n % 8));
}

static bool patch_mode(const char *mode, std::vector<uint8_t> &d) {
	uint16_t emachine; uint32_t eflags;
	memcpy(&emachine, d.data() + 0x12, 2);
	memcpy(&eflags, d.data() + 0x30, 4);
	if (emachine != 0xBE) { fprintf(stderr, "非 CUDA cubin\n"); return false; }
	uint32_t sm = eflags & 0xff;
	if (sm < 75) sm = (eflags >> 8) & 0xff;
	if (sm != 120 && sm != 121) { fprintf(stderr, "目标 SM%u 非 120/121\n", sm); return false; }
	uint64_t e_shoff; uint16_t e_shents, e_shnum, e_shstr;
	memcpy(&e_shoff, d.data() + 0x28, 8);
	memcpy(&e_shents, d.data() + 0x3A, 2);
	memcpy(&e_shnum, d.data() + 0x3C, 2);
	memcpy(&e_shstr, d.data() + 0x3E, 2);
	uint64_t stroff;
	memcpy(&stroff, d.data() + e_shstr * e_shents + 0x18, 8);
	bool is_e3m4 = !strcmp(mode, "mma_e3m4_ab");
	int matched = 0, patched = 0;
	for (int s = 0; s < e_shnum; s++) {
		const uint8_t *sh = d.data() + e_shoff + s * e_shents;
		uint32_t sh_type; uint64_t sh_flag, sh_off, sh_size;
		memcpy(&sh_type, sh + 0x04, 4);
		memcpy(&sh_flag, sh + 0x08, 8);
		memcpy(&sh_off, sh + 0x18, 8);
		memcpy(&sh_size, sh + 0x20, 8);
		if (sh_type != 1 || !(sh_flag & 0x4)) continue;
		for (uint64_t o = sh_off; o + 16 <= sh_off + sh_size; o += 16) {
			uint32_t op = d[o] | ((d[o + 1] & 0x0f) << 8);
			if (is_e3m4) {
				if (op != 0x47a && op != 0x27a) continue;
				if (getbit(d, o, 78) == 1 && getbit(d, o, 82) == 0 && getbit(d, o, 83) == 0 &&
				    getbit(d, o, 79) == 1 && getbit(d, o, 84) == 0 && getbit(d, o, 85) == 0) {
					setbit(d, o, 78, 0); setbit(d, o, 82, 1);
					setbit(d, o, 79, 0); setbit(d, o, 84, 1);
					patched++;
				}
				matched++;
			} else {
				if (op != 0x47f) continue;
				if (getbit(d, o, 83)) { fprintf(stderr, "OMMA 为 2X 形态, E0M3 非法\n"); return false; }
				if (getbit(d, o, 78) == 0 && getbit(d, o, 79) == 0) {
					setbit(d, o, 78, 1); setbit(d, o, 79, 1);
					patched++;
				}
				matched++;
			}
		}
	}
	(void)matched;
	if (!patched) { fprintf(stderr, "未补丁任何指令\n"); return false; }
	return true;
}

int main(int argc, char **argv) {
	if (argc >= 2 && !strcmp(argv[1], "--embed")) {
		if (argc < 4) { fprintf(stderr, "用法: %s --embed out.cpp name=file ...\n", argv[0]); return 2; }
		std::ofstream f(argv[2]);
		f << "// 由 tools/patch_cubin.cpp --embed 生成 — 补丁后的隐藏格式 cubin, 勿手改\n";
		f << "#include <cstdint>\n#include <cstddef>\n\n";
		for (int i = 3; i < argc; i++) {
			std::string spec = argv[i];
			auto eq = spec.find('=');
			if (eq == std::string::npos) return 2;
			std::string name = spec.substr(0, eq), path = spec.substr(eq + 1);
			std::ifstream g(path, std::ios::binary);
			std::vector<uint8_t> data((std::istreambuf_iterator<char>(g)), std::istreambuf_iterator<char>());
			f << "extern const unsigned char " << name << "[] = {\n";
			for (size_t j = 0; j < data.size(); j += 20) {
				for (size_t k = j; k < data.size() && k < j + 20; k++)
					f << (int)data[k] << ",";
				f << "\n";
			}
			f << "};\nconst size_t " << name << "_size = sizeof(" << name << ");\n\n";
		}
		printf("%s: %d 个 cubin 已嵌入\n", argv[2], argc - 3);
		return 0;
	}
	if (argc != 3) { fprintf(stderr, "用法: %s <mode> <cubin> | --embed out.cpp name=file...\n", argv[0]); return 2; }
	std::ifstream f(argv[2], std::ios::binary);
	std::vector<uint8_t> d((std::istreambuf_iterator<char>(f)), std::istreambuf_iterator<char>());
	if (d.size() < 64 || memcmp(d.data(), "\x7f" "ELF", 4) || d[4] != 2) { fprintf(stderr, "非 ELF64\n"); return 2; }
	if (!patch_mode(argv[1], d)) return 5;
	std::ofstream w(argv[2], std::ios::binary);
	w.write((const char *)d.data(), d.size());
	printf("%s: 已补丁 → %s\n", argv[1], argv[2]);
	return 0;
}
