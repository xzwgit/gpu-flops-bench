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

| GPU | 架构 | CC | 显存 | FP64 | FP32 | TF32 | BF16 | FP16 | INT8 | E4M3 | NVFP4 |
|---|---|---|---|---|---|---|---|---|---|---|---|
| <sub>H200 NVL</sub> | <sub>Hopper</sub> | <sub>9.0</sub> | <sub>141G</sub> | <sub>59.0</sub> | <sub>47.3</sub> | <sub>426</sub> | <sub>853</sub> | <sub>854</sub> | <sub>1630</sub> | <sub>1661</sub> | <sub>—</sub> |
| <sub>PRO 6000</sub> | <sub>Blackwell</sub> | <sub>12.0</sub> | <sub>96G</sub> | <sub>1.5</sub> | <sub>83.6</sub> | <sub>225</sub> | <sub>458</sub> | <sub>457</sub> | <sub>845</sub> | <sub>905</sub> | <sub>1608</sub> |
| <sub>5090</sub> | <sub>Blackwell</sub> | <sub>12.0</sub> | <sub>32G</sub> | <sub>1.8</sub> | <sub>83.2</sub> | <sub>126</sub> | <sub>254</sub> | <sub>254</sub> | <sub>906</sub> | <sub>774</sub> | <sub>1617</sub> |
| <sub>PRO 5000</sub> | <sub>Blackwell</sub> | <sub>12.0</sub> | <sub>48G</sub> | <sub>1.0</sub> | <sub>52.4</sub> | <sub>140</sub> | <sub>257</sub> | <sub>260</sub> | <sub>552</sub> | <sub>557</sub> | <sub>1064</sub> |
| <sub>5090 D v2</sub> | <sub>Blackwell</sub> | <sub>12.0</sub> | <sub>24G</sub> | <sub>1.7</sub> | <sub>83.7</sub> | <sub>119</sub> | <sub>241</sub> | <sub>241</sub> | <sub>665</sub> | <sub>661</sub> | <sub>1177</sub> |
| <sub>6000D</sub> | <sub>Blackwell</sub> | <sub>12.0</sub> | <sub>84G</sub> | <sub>1.3</sub> | <sub>67.5</sub> | <sub>72</sub> | <sub>151</sub> | <sub>150</sub> | <sub>391</sub> | <sub>288</sub> | <sub>946</sub> |
| <sub>4090</sub> | <sub>Ada</sub> | <sub>8.9</sub> | <sub>24G</sub> | <sub>1.3</sub> | <sub>57.6</sub> | <sub>90</sub> | <sub>179</sub> | <sub>179</sub> | <sub>676</sub> | <sub>354</sub> | <sub>—</sub> |
| <sub>GB10</sub> | <sub>Grace BW</sub> | <sub>12.1</sub> | <sub>128G</sub> | <sub>0.4</sub> | <sub>21.2</sub> | <sub>43</sub> | <sub>102</sub> | <sub>105</sub> | <sub>155</sub> | <sub>220</sub> | <sub>373</sub> |

> 单位: TFLOPS（INT8 为 TOPS）  GB10 为统一内存（CPU+GPU 共享）
> 数据为 cuBLASLt dense GEMM 实测值（非稀疏，isolated 隔离测试）
> 完整精度数据见 [GPU_TEST_CHECKLIST.md](nvidia/GPU_TEST_CHECKLIST.md)

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
