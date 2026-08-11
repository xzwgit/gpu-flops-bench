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

### NVIDIA（6 款，按算力从高到低排序）

| 精度 | H200 NVL (Hopper, 141GB) | PRO 6000 (Blackwell, 96GB) | RTX 5090 (Blackwell, 32GB) | PRO 5000 (Blackwell, 48GB) | 5090 D v2 (Blackwell, 24GB) | RTX 4090 (Ada, 24GB) |
|---|---|---|---|---|---|---|
| FP64 | 58.98 | 1.54 | 1.77 | 1.01 | 1.68 | 1.25 |
| FP32 | 47.28 | 83.60 | 83.24 | 52.41 | 83.70 | 57.55 |
| TF32 | 425.55 | 224.70 | 125.80 | 140.27 | 119.34 | 90.35 |
| BF16 | 853.29 | 457.61 | 254.03 | 257.12 | 240.72 | 179.20 |
| FP16 | 853.68 | 457.44 | 254.21 | 260.25 | 240.66 | 179.20 |
| INT8 | 1629.76 | 845.39 | 906.14 | 551.88 | 665.27 | 676.00 |
| FP8 E4M3 | 1660.83 | 905.32 | 773.52 | 557.34 | 660.66 | 354.31 |
| FP8 E5M2 | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED |
| NVFP4 | UNSUPPORTED | 1608.21 | 1617.46 | 1063.53 | 1177.03 | UNSUPPORTED |
| INT4 | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED |

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
