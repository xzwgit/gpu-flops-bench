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

### NVIDIA（9 款，按算力从高到低排序）

| <small>GPU</small> | <small>架构</small> | <small>CC</small> | <small>显存</small> | <small>FP64</small> | <small>FP32</small> | <small>TF32</small> | <small>BF16</small> | <small>FP16</small> | <small>INT8</small> | <small>E4M3</small> | <small>NVFP4</small> |
|---|---|---|---|---|---|---|---|---|---|---|---|
| <small>H200&nbsp;NVL</small> | <small>Hopper</small> | <small>9.0</small> | <small>141G</small> | <small>59.0</small> | <small>47.3</small> | <small>426</small> | <small>853</small> | <small>854</small> | <small>1630</small> | <small>1661</small> | <small>—</small> |
| <small>RTX&nbsp;PRO&nbsp;6000</small> | <small>Blackwell</small> | <small>12.0</small> | <small>96G</small> | <small>1.5</small> | <small>83.6</small> | <small>225</small> | <small>458</small> | <small>457</small> | <small>845</small> | <small>905</small> | <small>1608</small> |
| <small>RTX&nbsp;5090</small> | <small>Blackwell</small> | <small>12.0</small> | <small>32G</small> | <small>1.8</small> | <small>83.2</small> | <small>126</small> | <small>254</small> | <small>254</small> | <small>906</small> | <small>774</small> | <small>1617</small> |
| <small>RTX&nbsp;PRO&nbsp;5000</small> | <small>Blackwell</small> | <small>12.0</small> | <small>48G</small> | <small>1.0</small> | <small>52.4</small> | <small>140</small> | <small>257</small> | <small>260</small> | <small>552</small> | <small>557</small> | <small>1064</small> |
| <small>RTX&nbsp;5090&nbsp;D&nbsp;v2</small> | <small>Blackwell</small> | <small>12.0</small> | <small>24G</small> | <small>1.7</small> | <small>83.7</small> | <small>119</small> | <small>241</small> | <small>241</small> | <small>665</small> | <small>661</small> | <small>1177</small> |
| <small>RTX&nbsp;6000D</small> | <small>Blackwell</small> | <small>12.0</small> | <small>84G</small> | <small>1.3</small> | <small>67.5</small> | <small>72</small> | <small>151</small> | <small>150</small> | <small>391</small> | <small>288</small> | <small>946</small> |
| <small>RTX&nbsp;4090</small> | <small>Ada&nbsp;Lovelace</small> | <small>8.9</small> | <small>24G</small> | <small>1.3</small> | <small>57.6</small> | <small>90</small> | <small>179</small> | <small>179</small> | <small>676</small> | <small>354</small> | <small>—</small> |
| <small>GB10&nbsp;(Spark)</small> | <small>Grace&nbsp;Blackwell</small> | <small>12.1</small> | <small>128G</small> | <small>0.4</small> | <small>21.2</small> | <small>43</small> | <small>102</small> | <small>105</small> | <small>155</small> | <small>220</small> | <small>373</small> |
| <small>RTX&nbsp;3060</small> | <small>Ampere</small> | <small>8.6</small> | <small>12G</small> | <small>0.2</small> | <small>10.3</small> | <small>13</small> | <small>27</small> | <small>27</small> | <small>95</small> | <small>—</small> | <small>—</small> |

> 单位: TFLOPS（INT8 为 TOPS）  GB10 为统一内存（CPU+GPU 共享）
> 数据为 cuBLASLt dense GEMM 实测值（非稀疏，isolated 隔离测试）
> 完整精度数据见 [GPU_TEST_CHECKLIST.md](nvidia/GPU_TEST_CHECKLIST.md)

### NVIDIA 数据中心级（B300 SXM6，SM103）

> 2026-10-04 用 [cuda-u](https://github.com/xzwgit/cuda-u) v0.0.2（cuBLASLt GEMM 列）在 8 卡 B300 上实测。数据中心 Blackwell 的 mma.sync 只打 legacy tensor core（4x 低于 tcgen05），GEMM 列走 cuBLASLt dispatch tcgen05.mma，与实际推理/训练负载对应。

| <small>GPU</small> | <small>架构</small> | <small>CC</small> | <small>显存</small> | <small>BF16<br>mma / GEMM</small> | <small>FP8<br>mma / GEMM</small> | <small>NVFP4<br>GEMM</small> |
|---|---|---|---|---|---|---|
| <small>B300&nbsp;SXM6&nbsp;AC</small> | <small>Blackwell</small> | <small>10.3</small> | <small>275G</small> | <small>552 / **2247**</small> | <small>1958 / **4438**</small> | <small>**9202**</small> |

> 单位: TFLOPS。8 卡实测范围：BF16 2245-2247、FP8 4429-4439、NVFP4 9146-9420（±0.2%）。
> 其他：FP64 1.01、FP32(vector) 68.4、TF32(mma) 276、INT8(mma) 152、INT4 72 TFLOPS/TOPS。
> 带宽：H2D 55.1 / D2H 56.7 / D2D 5210 GB/s（spec 7672 GB/s HBM3e 7680bit）。
> 测试工具：[cuda-u](https://github.com/xzwgit/cuda-u) commit 128f2e4，gemm_bench.cpp cuBLASLt 路径。

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
