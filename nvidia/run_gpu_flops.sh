#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_FILE="${ROOT_DIR}/src/gpu_dense_bench.cu"
BUILD_DIR="${ROOT_DIR}/build"
BIN_FILE="${BUILD_DIR}/gpu_dense_bench"

die() {
  echo "ERROR: $*" >&2
  exit 1
}

command -v nvidia-smi >/dev/null 2>&1 || die "nvidia-smi not found. Install a working NVIDIA driver."
command -v nvcc >/dev/null 2>&1 || die "nvcc not found. Install the CUDA Toolkit and add its bin directory to PATH."

mkdir -p "${BUILD_DIR}"

arch_flags=()
while IFS= read -r cap; do
  cap="${cap//[[:space:]]/}"
  cap="${cap//./}"
  if [[ "${cap}" =~ ^[0-9]+$ ]]; then
    flag="-gencode=arch=compute_${cap},code=sm_${cap}"
    duplicate=0
    for existing in "${arch_flags[@]}"; do
      if [[ "${existing}" == "${flag}" ]]; then
        duplicate=1
      fi
    done
    if [[ "${duplicate}" -eq 0 ]]; then
      arch_flags+=("${flag}")
    fi
  fi
done < <(nvidia-smi --query-gpu=compute_cap --format=csv,noheader 2>/dev/null || true)

# Always include sm_120a (FP4 E2M1 mma.sync requires family-specific
# compilation target) and sm_100a/103a (datacenter Blackwell) regardless
# of what GPUs are present, so the binary works on any machine.
for extra_cap in 100a 103a 120a; do
  flag="-gencode=arch=compute_${extra_cap},code=sm_${extra_cap}"
  duplicate=0
  for existing in "${arch_flags[@]}"; do
    if [[ "${existing}" == "${flag}" ]]; then
      duplicate=1
    fi
  done
  if [[ "${duplicate}" -eq 0 ]]; then
    arch_flags+=("${flag}")
  fi
done

if [[ "${#arch_flags[@]}" -eq 0 ]]; then
  arch_flags+=("-arch=native")
fi

# 每次启动都用当前环境的 CUDA 重新编译，避免使用历史遗留的预编译二进制
# （例如 tar 包解压时保留了打包时间戳，源码时间戳不比二进制新，导致换 CUDA
# 版本或换机器后仍误用旧二进制）。
# 多卡调度与报告生成已内置进二进制（无需 Python）；NVML 用于遥测采集。
# 隐藏格式 (FP8 E3M4 / FP4 E0M3): 占位拼写编译 → cubin 位级补丁 → 嵌入
# (仅 SM120/121 可用; 其他架构运行时报 UNSUPPORTED)
echo "Building hidden-format cubins (E3M4/E0M3)..."
g++ -O2 -o "${BUILD_DIR}/patch_cubin" "${ROOT_DIR}/tools/patch_cubin.cpp"
nvcc -cubin -O3 -gencode=arch=compute_120a,code=sm_120a \
  "${ROOT_DIR}/src/hidden_mma_kernels.cu" -o "${BUILD_DIR}/hk_120.cubin"
nvcc -cubin -O3 -gencode=arch=compute_121a,code=sm_121a \
  "${ROOT_DIR}/src/hidden_mma_kernels.cu" -o "${BUILD_DIR}/hk_121.cubin"
for v in 120 121; do
  for m in e3m4 e0m3; do
    cp "${BUILD_DIR}/hk_${v}.cubin" "${BUILD_DIR}/${m}_${v}.cubin"
    "${BUILD_DIR}/patch_cubin" "mma_${m}_ab" "${BUILD_DIR}/${m}_${v}.cubin"
  done
done
"${BUILD_DIR}/patch_cubin" --embed "${BUILD_DIR}/hidden_cubins.cpp" \
  cubin_e3m4_120="${BUILD_DIR}/e3m4_120.cubin" cubin_e0m3_120="${BUILD_DIR}/e0m3_120.cubin" \
  cubin_e3m4_121="${BUILD_DIR}/e3m4_121.cubin" cubin_e0m3_121="${BUILD_DIR}/e0m3_121.cubin"

echo "Building CUDA benchmark with $(nvcc --version | grep -i release)..."
nvcc -O3 -std=c++17 -lineinfo \
  "${arch_flags[@]}" \
  "${SRC_FILE}" "${BUILD_DIR}/hidden_cubins.cpp" \
  -lcublasLt -lcublas -lnvidia-ml -lcuda \
  -o "${BIN_FILE}"

exec "${BIN_FILE}" "$@"
