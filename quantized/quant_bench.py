#!/usr/bin/env python3
"""quant_bench.py — 量化推理 GEMM 有效吞吐基准 (Humming 引擎)

在 GPU 上测量 W4A16 / W8A8 / MXFP4×FP8 的有效 dense GEMM 吞吐, 并以
BF16 cuBLAS (torch.matmul) 为基线。结果写入 markdown + csv。

用法:
  python3 quant_bench.py [--device 0] [--shape-n 4096] [--shape-k 4096]
                         [--ms 1 16 64 256 1024 4096] [--out DIR]

环境要求: PyTorch (建议 cu13x) + CUDA toolkit (JIT 编译用 nvcc),
humming 以源码方式内置在本目录 humming-src/ (PYTHONPATH 自动加入)。
"""
import argparse
import csv
import datetime
import os
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "humming-src"))

# 必须在 import torch 之前固定可见设备: humming 内部固定使用 cuda:0,
# 混用 set_device 会导致内核在错误设备上空转 (时间塌缩到 ~1.5µs)
_dev = "0"
for i, a in enumerate(sys.argv):
    if a == "--device" and i + 1 < len(sys.argv):
        _dev = sys.argv[i + 1]
os.environ["CUDA_VISIBLE_DEVICES"] = _dev

import torch  # noqa: E402

M_SWEEP_DEFAULT = [1, 16, 64, 256, 1024, 4096]

# (名称, bench_humming 参数片段, 需要 input_scale_group_size)
CASES = [
    ("W4A16 int4xbf16 gs128", dict(a_dtype="bfloat16", b_dtype="int4",
                                    bs_dtype="bfloat16", wgs=128, igs=0)),
    ("W8A8 int8xint8 gs128", dict(a_dtype="int8", b_dtype="int8",
                                   bs_dtype="bfloat16", wgs=128, igs=128)),
    ("W4A8 mxfp4xfp8 gs32", dict(a_dtype="float8e4m3", b_dtype="float4e2m1",
                                  bs_dtype="float8e8m0", wgs=32, igs=32)),
]


def check_env(dev):
    dev = 0   # CUDA_VISIBLE_DEVICES 已把目标卡映射为 0
    cap = torch.cuda.get_device_capability(dev)
    name = torch.cuda.get_device_name(dev)
    p = torch.cuda.get_device_properties(dev)
    print(f"GPU{dev}: {name}, SM {cap[0]}.{cap[1]}, {p.multi_processor_count} SMs, "
          f"torch {torch.__version__} ({torch.version.cuda})")
    if cap[0] < 7:
        raise SystemExit("需要 SM75 (Turing) 及以上")
    nvcc = os.environ.get("CUDA_HOME", "/usr/local/cuda") + "/bin/nvcc"
    if not os.path.exists(nvcc):
        raise SystemExit("未找到 nvcc (CUDA_HOME/bin/nvcc) — Humming JIT 需要 CUDA 工具链")
    ver = subprocess.run([nvcc, "--version"], capture_output=True, text=True).stdout
    print("nvcc:", ver.strip().splitlines()[-1])
    return cap


def bench_humming_case(args, case, m_list):
    """调用内置 humming 的 bench_humming 流程 (与上游脚本同参)"""
    sys.path.insert(0, os.path.join(HERE, "humming-src"))
    from benchmarks import bench_humming as bh  # noqa

    kw = dict(shape_n=args.shape_n, shape_k=args.shape_k, c_dtype="bfloat16",
              a_dtype=case["a_dtype"], b_dtype=case["b_dtype"], bs_dtype=case["bs_dtype"],
              weight_scale_group_size=case["wgs"], input_scale_group_size=case["igs"],
              shape_m_list=m_list)
    rows = bh.bench_humming(**kw)
    return rows


def bench_bf16(dev, m_list, n, k, reps=50):
    out = []
    for m in m_list:
        a = torch.randn(m, k, dtype=torch.bfloat16, device=f"cuda:{dev}")
        b = torch.randn(n, k, dtype=torch.bfloat16, device=f"cuda:{dev}").t()
        for _ in range(20):
            c = a @ b
        torch.cuda.synchronize()
        ts = []
        for _ in range(reps):
            t0 = torch.cuda.Event(enable_timing=True)
            t1 = torch.cuda.Event(enable_timing=True)
            t0.record()
            c = a @ b
            t1.record()
            torch.cuda.synchronize()
            ts.append(t0.elapsed_time(t1))
        t = min(ts)
        out.append((m, t, 2 * m * n * k / t / 1e9))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--device", type=int, default=0)
    ap.add_argument("--shape-n", type=int, default=4096)
    ap.add_argument("--shape-k", type=int, default=4096)
    ap.add_argument("--ms", type=int, nargs="+", default=M_SWEEP_DEFAULT)
    ap.add_argument("--out", default=None)
    args = ap.parse_args()

    check_env(args.device)

    stamp = datetime.datetime.now(datetime.timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    outdir = args.out or os.path.join(HERE, "..", "results", stamp + "-quant")
    os.makedirs(outdir, exist_ok=True)

    results = {}
    for name, case in CASES:
        print(f"=== {name} ===")
        try:
            rows = bench_humming_case(args, case, args.ms)
            results[name] = rows
        except Exception as e:
            print(f"  失败: {type(e).__name__}: {e}")
            results[name] = None
    print("=== BF16 cuBLAS 基线 ===")
    results["BF16 cuBLAS"] = bench_bf16(0, args.ms, args.shape_n, args.shape_k)

    # ---- 输出 ----
    md = [f"# 量化推理 GEMM 基准 (Humming) — {stamp}",
          "",
          f"GPU: {torch.cuda.get_device_name(0)} (CUDA_VISIBLE_DEVICES={_dev}), "
          f"torch {torch.__version__} ({torch.version.cuda})",
          f"形状 N=K={args.shape_n}, 有效 TFLOPS = 2MNK/t", "",
          "| M | " + " | ".join(name for name, _ in CASES) + " | BF16 cuBLAS |",
          "|" + "---|" * (len(CASES) + 2)]
    csv_rows = []
    for i, m in enumerate(args.ms):
        cells = [str(m)]
        for name, _ in CASES:
            rows = results[name]
            if rows and i < len(rows):
                t = rows[i]["time"]              # ms
                tf = rows[i]["compute_tops"]     # 有效 TFLOPS
                cells.append(f"{tf:.1f}")
                csv_rows.append([m, name, t, tf])
            else:
                cells.append("-")
                csv_rows.append([m, name, "", ""])
        bf = results["BF16 cuBLAS"][i]
        cells.append(f"{bf[2]:.1f}")
        csv_rows.append([m, "BF16 cuBLAS", bf[1], bf[2]])
        md.append("| " + " | ".join(cells) + " |")

    md_text = "\n".join(md) + "\n"
    with open(os.path.join(outdir, "quant_report.md"), "w") as f:
        f.write(md_text)
    with open(os.path.join(outdir, "quant_report.csv"), "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["M", "case", "time_ms", "effective_tflops"])
        w.writerows(csv_rows)
    print()
    print(md_text)
    print(f"报告: {os.path.abspath(outdir)}")


if __name__ == "__main__":
    main()
