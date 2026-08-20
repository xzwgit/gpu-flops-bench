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

| <small>GPU</small> | <small>架构</small> | <small>CC</small> | <small>显存</small> | <small>FP64</small> | <small>FP32</small> | <small>TF32</small> | <small>BF16</small> | <small>FP16</small> | <small>INT8</small> | <small>E4M3</small> | <small>NVFP4</small> |
|---|---|---|---|---|---|---|---|---|---|---|---|
| <small>H200 NVL</sub> | <small>Hopper</sub> | <small>9.0</sub> | <small>141G</sub> | <small>59.0</sub> | <small>47.3</sub> | <small>426</sub> | <small>853</sub> | <small>854</sub> | <small>1630</sub> | <small>1661</sub> | <small>—</sub> |
| <small>PRO 6000</sub> | <small>Blackwell</sub> | <small>12.0</sub> | <small>96G</sub> | <small>1.5</sub> | <small>83.6</sub> | <small>225</sub> | <small>458</sub> | <small>457</sub> | <small>845</sub> | <small>905</sub> | <small>1608</sub> |
| <small>5090</sub> | <small>Blackwell</sub> | <small>12.0</sub> | <small>32G</sub> | <small>1.8</sub> | <small>83.2</sub> | <small>126</sub> | <small>254</sub> | <small>254</sub> | <small>906</sub> | <small>774</sub> | <small>1617</sub> |
| <small>PRO 5000</sub> | <small>Blackwell</sub> | <small>12.0</sub> | <small>48G</sub> | <small>1.0</sub> | <small>52.4</sub> | <small>140</sub> | <small>257</sub> | <small>260</sub> | <small>552</sub> | <small>557</sub> | <small>1064</sub> |
| <small>5090 D v2</sub> | <small>Blackwell</sub> | <small>12.0</sub> | <small>24G</sub> | <small>1.7</sub> | <small>83.7</sub> | <small>119</sub> | <small>241</sub> | <small>241</sub> | <small>665</sub> | <small>661</sub> | <small>1177</sub> |
| <small>6000D</sub> | <small>Blackwell</sub> | <small>12.0</sub> | <small>84G</sub> | <small>1.3</sub> | <small>67.5</sub> | <small>72</sub> | <small>151</sub> | <small>150</sub> | <small>391</sub> | <small>288</sub> | <small>946</sub> |
| <small>4090</sub> | <small>Ada</sub> | <small>8.9</sub> | <small>24G</sub> | <small>1.3</sub> | <small>57.6</sub> | <small>90</sub> | <small>179</sub> | <small>179</sub> | <small>676</sub> | <small>354</sub> | <small>—</sub> |
| <small>GB10</sub> | <small>Grace BW</sub> | <small>12.1</sub> | <small>128G</sub> | <small>0.4</sub> | <small>21.2</sub> | <small>43</sub> | <small>102</sub> | <small>105</sub> | <small>155</sub> | <small>220</sub> | <small>373</sub> |

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
