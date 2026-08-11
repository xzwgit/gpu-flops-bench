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

### NVIDIA（6 款）

| GPU | 架构 | CC | 显存 | NVFP4 | FP8 E4M3 |
|---|---|---|---|---|---|
| RTX 4090 | Ada Lovelace | 8.9 | 24 GB | ❌ | ✅ 354.31 |
| RTX 5090 D v2 | Blackwell | 12.0 | 24 GB | ✅ 1177.03 | ✅ 660.66 |
| RTX 5090 | Blackwell | 12.0 | 32 GB | ✅ 1617.46 | ✅ 773.52 |
| RTX PRO 5000 | Blackwell | 12.0 | 48 GB | ✅ 1063.53 | ✅ 557.34 |
| RTX PRO 6000 | Blackwell | 12.0 | 96 GB | ✅ 1608.21 | ✅ 905.32 |
| H200 NVL | Hopper | 9.0 | 141 GB | ❌ | ✅ 1660.83 |

> 详细数据见下方性能对比表

### AMD（待测）

| GPU | 架构 | 状态 |
|---|---|---|
| MI300X | CDNA3 | 待测 |

## 性能对比表（单卡实测, dense GEMM）

| 精度 | RTX 4090 | 5090 D v2 | RTX 5090 | PRO 5000 | PRO 6000 | H200 NVL |
|---|---|---|---|---|---|---|
| FP64 | 1.25 | 1.68 | 1.77 | 1.01 | 1.54 | 58.98 |
| FP32 | 57.55 | 83.70 | 83.24 | 52.41 | 83.60 | 47.28 |
| TF32 | 90.35 | 119.34 | 125.80 | 140.27 | 224.70 | 425.55 |
| BF16 | 179.20 | 240.72 | 254.03 | 257.12 | 457.61 | 853.29 |
| FP16 | 179.20 | 240.66 | 254.21 | 260.25 | 457.44 | 853.68 |
| INT8 | 676.00 | 665.27 | 906.14 | 551.88 | 845.39 | 1629.76 |
| FP8 E4M3 | 354.31 | 660.66 | 773.52 | 557.34 | 905.32 | 1660.83 |
| FP8 E5M2 | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED |
| NVFP4 | UNSUPPORTED | 1177.03 | 1617.46 | 1063.53 | 1608.21 | UNSUPPORTED |
| INT4 | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED |

> 单位: TFLOPS（INT8 为 TOPS）
> NVIDIA 数据为 cuBLASLt dense GEMM 实测值（非稀疏，isolated 隔离测试）

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
