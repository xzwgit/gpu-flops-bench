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

### B300 / PRO 6000（gpu-flops-bench v2 实测：cuBLASLt GEMM + mma.sync 双列）

> 2026-10-04 用本工具 v2 在 B300 8 卡和 PRO 6000 上实测。GEMM 列走 cuBLASLt（tcgen05 dispatch），mma 列走 mma.sync 内核（legacy warp-level）。

| <small>GPU</small> | <small>架构</small> | <small>CC</small> | <small>显存</small> | <small>FP64</small> | <small>FP32</small> | <small>TF32</small> | <small>BF16</small> | <small>BF16<br>mma</small> | <small>FP16</small> | <small>INT8</small> | <small>FP8<br>E4M3</small> | <small>FP8<br>E4M3 mma</small> | <small>NVFP4</small> | <small>INT4</small> | <small>FP4<br>E2M1</small> |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| <small>B300&nbsp;SXM6&nbsp;AC</small> | <small>SM103</small> | <small>10.3</small> | <small>275G</small> | <small>1.05</small> | <small>68.8</small> | <small>**1101**</small> | <small>**2235**</small> | <small>551</small> | <small>**2235**</small> | <small>151</small> | <small>**4377**</small> | <small>1958</small> | <small>**10441**</small> | <small>74</small> | <small>N/A</small> |
| <small>RTX&nbsp;PRO&nbsp;6000</small> | <small>SM120</small> | <small>12.0</small> | <small>96G</small> | <small>1.53</small> | <small>80.6</small> | <small>225</small> | <small>**457**</small> | <small>462</small> | <small>457</small> | <small>882</small> | <small>**906**</small> | <small>924</small> | <small>**1619**</small> | <small>235</small> | <small>924</small> |

> 单位: TFLOPS（INT8/INT4 为 TOPS）
> B300 8 卡一致性：BF16 2233-2235、NVFP4 10360-10476（±0.2%）；8 卡 concurrent 聚合线性度≥99.7%
>
> **架构发现**：
> - **SM120 (PRO 6000) 上 mma.sync ≈ GEMM（满速）**：BF16 462 vs 457、FP8 924 vs 906——消费级 Blackwell 的 mma.sync 与 cuBLASLt 走同一硬件路径
> - **SM103 (B300) 上 mma.sync 只有 GEMM 的 25-45%**：BF16 551 vs 2235 (25%)、FP8 1958 vs 4377 (45%)——数据中心 Blackwell 需 tcgen05.mma（cuBLASLt dispatch），mma.sync 是 legacy 降档路径
> - **B300 INT8 = 151 TOPS（所有标准 API 路径一致：mma.sync ≈ cuBLASLt INT32I ≈ 149-152）**，远低于 FP8 的 4377。硬件 spec INT8 ≈ FP8 ≈ 4500 TOPS（同一 8-bit tensor core），纯粹是 **cuBLASLt 未给 INT8 dispatch tcgen05**。实际 8-bit 推理推荐用 FP8 E4M3 替代（同一硬件，29× 快于 INT32I）
> - **FP4 E2M1**：PRO 6000 有值 924（CC 12.0 的 mma.sync kind::f8f6f4），B300 N/A（CC 10.3）
> - INT8 F32acc（混合精度）在 B300 上仅 40 TOPS，比 INT32I 还差——证实不是计算类型问题，是 INT8 整体无 tcgen05 路径

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
