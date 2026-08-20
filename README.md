# gpu-flops-bench

多厂商 GPU 稠密 GEMM FLOPS 基准测试工具（NVIDIA CUDA + AMD ROCm）

> 🤖 本项目的代码编写、GPU 性能测试与更新迭代主要由 AI 完成。

## 目录结构

```
gpu-flops-bench/
├── README.md                          # 本文件（统一对比）
├── LICENSE                            # MIT
├── run_bench.sh                       # ⭐ 统一入口（自动检测 GPU 厂商）
├── nvidia/                            # NVIDIA CUDA 版 (cuBLASLt)
│   ├── src/gpu_dense_bench.cu         # 主程序 (C++17, 自给自足, 无需 Python)
│   ├── run_gpu_flops.sh / .bat        # 一键编译+运行
│   ├── GPU_TEST_CHECKLIST.md          # 已测 GPU 检查清单
│   ├── results/                       # 原始测试结果 (md/csv/json)
│   └── tools/run_multi_gpu.py         # 早期 Python 备用脚本
├── amd/                               # AMD ROCm 版 (待实现)
│   └── README.md                      # 占位
└── docs/
```

## 已测 GPU

### NVIDIA（8 款，按算力从高到低排序）

<small>

| GPU | 架构 | CC | 显存 | FP64 | FP32 | TF32 | BF16 | FP16 | INT8 | FP8 E4M3 | NVFP4 |
|---|---|---|---|---|---|---|---|---|---|---|---|
| H200 NVL | Hopper | 9.0 | 141 GB | 58.98 | 47.28 | 425.55 | 853.29 | 853.68 | 1629.76 | 1660.83 | UNSUPPORTED |
| RTX PRO 6000 | Blackwell | 12.0 | 96 GB | 1.54 | 83.60 | 224.70 | 457.61 | 457.44 | 845.39 | 905.32 | 1608.21 |
| RTX 5090 | Blackwell | 12.0 | 32 GB | 1.77 | 83.24 | 125.80 | 254.03 | 254.21 | 906.14 | 773.52 | 1617.46 |
| RTX PRO 5000 | Blackwell | 12.0 | 48 GB | 1.01 | 52.41 | 140.27 | 257.12 | 260.25 | 551.88 | 557.34 | 1063.53 |
| RTX 5090 D v2 | Blackwell | 12.0 | 24 GB | 1.68 | 83.70 | 119.34 | 240.72 | 240.66 | 665.27 | 660.66 | 1177.03 |
| RTX 6000D | Blackwell | 12.0 | 84 GB | 1.32 | 67.52 | 72.26 | 150.53 | 150.03 | 391.06 | 287.89 | 946.03 |
| RTX 4090 | Ada Lovelace | 8.9 | 24 GB | 1.25 | 57.55 | 90.35 | 179.20 | 179.20 | 676.00 | 354.31 | UNSUPPORTED |
| GB10 (DGX Spark) | Grace Blackwell | 12.1 | 128 GB* | 0.40 | 21.24 | 42.62 | 101.98 | 105.08 | 155.47 | 219.83 | 372.54 |

</small>

> 单位: TFLOPS（INT8 为 TOPS）
> 数据为 cuBLASLt dense GEMM 实测值（非稀疏，isolated 隔离测试，取各精度最佳尺寸中位数）

### AMD（待测）

| GPU | 架构 | 状态 |
|---|---|---|
| MI300X | CDNA3 | 待测 |

## 运行方式

### 统一入口（推荐）

```bash
bash run_bench.sh               # 自动检测 GPU 厂商并运行
bash run_bench.sh --quick       # 快速模式
bash run_bench.sh --device 0    # 只测 GPU 0
```

自动检测 GPU 类型（NVIDIA / AMD），调用对应子工具：

| 检测到 | 调用 | 编译器 | BLAS 库 |
|---|---|---|---|
| NVIDIA | `nvidia/run_gpu_flops.sh` | nvcc | cuBLASLt |
| AMD | `amd/run_gpu_flops.sh` (待实现) | hipcc | hipBLASLt |

### NVIDIA（单独运行）

```bash
cd nvidia
bash run_gpu_flops.sh           # 编译 + 运行（自动检测 GPU 架构）
bash run_gpu_flops.sh --quick   # 快速模式（每精度只测一个尺寸）
```

无需安装 Python。编译时链接 NVML（`-lnvidia-ml`，CUDA Toolkit 自带）。

### AMD（待实现）

```bash
cd amd
bash run_gpu_flops.sh           # 待实现
```

## 测新 GPU 后的操作步骤

详见 [nvidia/GPU_TEST_CHECKLIST.md](nvidia/GPU_TEST_CHECKLIST.md)

## 环境要求

- NVIDIA: CUDA Toolkit 13.0+, NVIDIA 驱动
- AMD: ROCm 6.0+（待实现）
