# gpu_flops_bench

多厂商 GPU 稠密 GEMM FLOPS 基准测试工具（NVIDIA CUDA + AMD ROCm）

> 🤖 本项目的代码编写、GPU 性能测试与更新迭代主要由 AI 完成。

## 目录结构

```
gpu_flops_bench/
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

### NVIDIA 汇总表（11 款 + 2 解锁态，cuda-u v0.0.3 统一口径，2026-10-27）

> **一张表合并历次实测**（v1 cuBLASLt GEMM / v2 双列 / 解锁 A/B / 隐藏格式）。
> 数据源三档：① 0.0.3/峰值混合行：B300@10.10.3.55（GEMM 列 = 2026-10-28 完整尺寸扫描峰值，mma 列 = cuda-u 0.0.3）、PRO 6000@10.10.3.155、5090@10.0.1.116、6000D@10.10.3.157、4090 解锁@10.0.1.92（此四行 GEMM/mma 均为 cuda-u 0.0.3，固定 8192³）；② 解锁 A/B 行（3090 锁定/解锁，2026-10-25）；③ v1 GEMM 行（H200/PRO 5000/5090D v2/GB10/3060，未跑 0.0.3，mma 与隐藏列未测）。
> 口径：BF16/INT8/E4M3/NVFP4 列 = cuBLASLt GEMM；带 mma 后缀及 INT4/FP4 列 = mma.sync 发射率；0.0.3 行的 TF32/FP16 为 mma 口径（cuda-u 无此二者的 GEMM 列）。单位 TFLOPS（INT8/INT4 为 TOPS）。隐藏格式列仅 SM120/121 有硬件路径；SM103 (B300) 工具未实现 tcgen05 路径故 N/A；PRO 5000/5090D v2/GB10 (SM121) 有硬件未测。

| <small>GPU</small> | <small>架构</small> | <small>CC</small> | <small>显存</small> | <small>FP64</small> | <small>FP32</small> | <small>TF32</small> | <small>BF16</small> | <small>BF16<br>mma</small> | <small>FP16</small> | <small>INT8</small> | <small>FP8<br>E4M3</small> | <small>FP8<br>E4M3 mma</small> | <small>NVFP4</small> | <small>INT4</small> | <small>FP4<br>E2M1</small> | <small>FP8<br>E3M4</small> | <small>FP4<br>E0M3</small> |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| <small>B300&nbsp;SXM6&nbsp;AC</small> | <small>SM103</small> | <small>10.3</small> | <small>275G</small> | <small>1.05</small> | <small>68.8</small> | <small>**1101**</small> | <small>**2235**</small> | <small>551</small> | <small>**2235**</small> | <small>151</small> | <small>**4378**</small> | <small>1958</small> | <small>**10414**</small> | <small>72</small> | <small>N/A</small> | <small>N/A</small> | <small>N/A</small> |
| <small>H200&nbsp;NVL</small> | <small>Hopper</small> | <small>9.0</small> | <small>141G</small> | <small>**59.0**</small> | <small>47.3</small> | <small>426</small> | <small>853</small> | <small>—</small> | <small>854</small> | <small>**1630**</small> | <small>1661</small> | <small>—</small> | <small>—</small> | <small>—</small> | <small>—</small> | <small>N/A</small> | <small>N/A</small> |
| <small>RTX&nbsp;PRO&nbsp;6000&nbsp;SE</small> | <small>SM120</small> | <small>12.0</small> | <small>96G</small> | <small>1.5</small> | <small>**100.3**</small> | <small>222</small> | <small>449</small> | <small>444</small> | <small>444</small> | <small>848</small> | <small>892</small> | <small>887</small> | <small>1590</small> | <small>138</small> | <small>923</small> | <small>**928**</small> | <small>194</small> |
| <small>RTX&nbsp;5090</small> | <small>SM120</small> | <small>12.0</small> | <small>32G</small> | <small>1.7</small> | <small>83.2</small> | <small>126</small> | <small>241</small> | <small>253</small> | <small>253</small> | <small>886</small> | <small>877</small> | <small>506</small> | <small>**1592**</small> | <small>151</small> | <small>503</small> | <small>504</small> | <small>177</small> |
| <small>RTX&nbsp;PRO&nbsp;5000</small> | <small>SM120</small> | <small>12.0</small> | <small>48G</small> | <small>1.0</small> | <small>52.4</small> | <small>140</small> | <small>257</small> | <small>—</small> | <small>260</small> | <small>552</small> | <small>557</small> | <small>—</small> | <small>1064</small> | <small>—</small> | <small>—</small> | <small>未测</small> | <small>未测</small> |
| <small>RTX&nbsp;5090D&nbsp;v2</small> | <small>SM120</small> | <small>12.0</small> | <small>24G</small> | <small>1.7</small> | <small>83.7</small> | <small>119</small> | <small>241</small> | <small>—</small> | <small>241</small> | <small>665</small> | <small>661</small> | <small>—</small> | <small>1177</small> | <small>—</small> | <small>—</small> | <small>未测</small> | <small>未测</small> |
| <small>RTX&nbsp;6000D</small> | <small>SM120</small> | <small>12.0</small> | <small>84G</small> | <small>1.2</small> | <small>67.5</small> | <small>73</small> | <small>145</small> | <small>145</small> | <small>144</small> | <small>282</small> | <small>287</small> | <small>289</small> | <small>557</small> | <small>112</small> | <small>377</small> | <small>289</small> | <small>141</small> |
| <small>RTX&nbsp;4090</small> | <small>SM89</small> | <small>8.9</small> | <small>24G</small> | <small>1.25</small> | <small>57.2</small> | <small>89</small> | <small>178</small> | <small>181</small> | <small>175</small> | <small>672</small> | <small>352</small> | <small>360</small> | <small>N/A</small> | <small>1434</small> | <small>N/A</small> | <small>N/A</small> | <small>N/A</small> |
| <small>RTX&nbsp;4090&nbsp;解锁</small> | <small>SM89</small> | <small>8.9</small> | <small>48G</small> | <small>1.2</small> | <small>80.1</small> | <small>177</small> | <small>207</small> | <small>**346**</small> | <small>338</small> | <small>663</small> | <small>568</small> | <small>713</small> | <small>N/A</small> | <small>1423</small> | <small>N/A</small> | <small>N/A</small> | <small>N/A</small> |
| <small>GB10&nbsp;(Spark)</small> | <small>Grace&nbsp;Blackwell</small> | <small>12.1</small> | <small>128G</small> | <small>0.4</small> | <small>21.2</small> | <small>43</small> | <small>102</small> | <small>—</small> | <small>105</small> | <small>155</small> | <small>220</small> | <small>—</small> | <small>373</small> | <small>—</small> | <small>—</small> | <small>未测</small> | <small>未测</small> |
| <small>RTX&nbsp;3090</small> | <small>SM86</small> | <small>8.6</small> | <small>24G</small> | <small>0.56</small> | <small>30.1</small> | <small>41</small> | <small>82</small> | <small>83</small> | <small>82</small> | <small>296</small> | <small>N/A</small> | <small>N/A</small> | <small>N/A</small> | <small>661</small> | <small>N/A</small> | <small>N/A</small> | <small>N/A</small> |
| <small>RTX&nbsp;3090&nbsp;解锁</small> | <small>SM86</small> | <small>8.6</small> | <small>24G</small> | <small>0.57</small> | <small>30.0</small> | <small>77</small> | <small>144</small> | <small>**165**</small> | <small>145</small> | <small>294</small> | <small>N/A</small> | <small>N/A</small> | <small>N/A</small> | <small>661</small> | <small>N/A</small> | <small>N/A</small> | <small>N/A</small> |
| <small>RTX&nbsp;3060</small> | <small>Ampere</small> | <small>8.6</small> | <small>12G</small> | <small>0.2</small> | <small>10.3</small> | <small>13</small> | <small>27</small> | <small>—</small> | <small>27</small> | <small>95</small> | <small>N/A</small> | <small>N/A</small> | <small>N/A</small> | <small>—</small> | <small>N/A</small> | <small>N/A</small> | <small>N/A</small> |

> GB10 为统一内存（CPU+GPU 共享）。**GEMM 列尺寸口径**：B300 与 v1 行为逐精度峰值搜索（NVFP4 峰在 16384³）；其余 0.0.3 行固定 8192³。低精度（FP4/FP8）tensor 管线利用率随尺寸显著爬升——B300 NVFP4 从 8192³ 的 8407~9238 爬到 16384³ 的 10414（+12~24%），跨表对比低精度列须对齐尺寸。4090 解锁 = FEAT_OVR 发射率解锁（gpu-unlock，FP16/BF16/TF32 tensor 路径 ×2）；3090 解锁同机制。
>
> **关键发现**：
> - **解锁**：4090 解锁后 BF16 mma 181→346（×1.9）、TF32 89→177（×2.0）、E4M3 mma 360→713（×2.0），GEMM 受功率墙只兑现一部分（BF16 178→207）；对照组 INT8/INT4 持平（整数路径无锁）；3090 同机制复现（BF16 mma ×2.0）。输出校验全 PASS
> - **隐藏格式（E3M4/E0M3，SM120/121 专属）**：E3M4 与 E4M3 同槽（PRO 6000 928 vs 887、5090 504 vs 506、6000D 289 vs 289）——价值在数值（尾数多 1 位，量化误差减半）而非算力；**E0M3（整数值 FP4）让 INT4 权重骑 FP4 快路径：PRO 6000 194 vs INT4 遗留 138（+40%）、5090 177 vs 151（+17%）**。编码发现 [Humming](https://github.com/vllm-project/humming)，测量 [cuda-u](https://github.com/xzwgit/cuda-u) v0.0.3
> - **SM103 (B300) 双面性**：BF16/FP8/NVFP4 走 tcgen05 极强（2247/4439/10410@16384³），但 mma.sync 降档至 25-45%、**INT8=151（cuBLASLt 未 dispatch tcgen05，8-bit 推理应用 E4M3 替代，29×）**、INT4=74 同因
> - **mma/GEMM 比值的架构分代**：SM86/SM89/SM120 ≈1.0（mma.sync 满速），仅数据中心 SM103 把 legacy 路径降档；RTX 6000D 例外（0.83/0.75，出口版限速模式，三台机器独立复现 145-176 区间）
> - **INT4 快路径的消亡**：Ampere 661（2.2× INT8）→ Ada 1434（2.1×）→ Blackwell 74~151（0.08~0.27×），低比特整数全面让位 FP8/NVFP4/E0M3
> - H200 FP64=59（数据中心卡独有优势）；PRO 6000 SE D2D 实测 5282 GB/s 为 128MB L2 命中效应（spec 1598）

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

默认精度列表：`fp64,fp32,tf32,bf16,bf16_mma,fp16,int8,int8_mma,fp8_e4m3,fp8_e4m3_mma,e3m4_mma,e0m3_mma,nvfp4,int4,fp4_e2m1`
- `_mma` 后缀 = mma.sync 指令级发射率（非 GEMM）
- **e3m4_mma / e0m3_mma** = 隐藏 Tensor 格式（SM120/121 专属）：PTX/cuBLASLt 无路径，
  构建期以占位拼写编译 cubin 后做 SASS 位级补丁（`tools/patch_cubin.cpp`，
  编码发现 [Humming](https://github.com/vllm-project/humming)），运行时经驱动 API 加载。其他架构报 UNSUPPORTED

### AMD（待实现）

```bash
cd amd
bash run_gpu_flops.sh           # 待实现
```

### 量化推理吞吐（Humming 引擎）

硬件峰值之外的第二个维度：**W4A16 / W8A8 / MXFP4×FP8 量化 GEMM 有效吞吐**，
以 BF16 cuBLAS 为基线。衡量的是推理框架实际可达的量化计算性能（含核内反量化、
scale 融合开销），与上层 cuBLASLt 峰值互补。

```bash
bash run_bench.sh --quant                          # GPU 0, N=K=4096, M 扫 1..4096
bash run_bench.sh --quant --device 6 --ms 1 64 1024 4096
```

- 引擎：[Humming](https://github.com/vllm-project/humming)（Apache-2.0），
  源码已内置 `quantized/humming-src/`（pin commit 见其 VENDORED.md），无需 pip 安装
- 环境：PyTorch（建议 cu130+）+ CUDA 工具链（nvcc，JIT 编译）+ `pip install triton tqdm`
- 结果写入 `results/<时间戳>-quant/quant_report.{md,csv}`
- 支持 SM75 (Turing) 起的全部架构；多卡用 `--device N`

RTX 4090（解锁态）参考值，N=K=4096，有效 TFLOPS = 2MNK/t：

| M | W4A16 | W8A8 | MXFP4×FP8 | BF16 cuBLAS |
|---|---|---|---|---|
| 1 | 1.7 | 1.1 | 1.7 | 1.4 |
| 64 | 83.7 | 52.7 | 73.6 | 77.9 |
| 1024 | 278.6 | 329.7 | 277.2 | 234.6 |
| 4096 | 275.0 | 375.4 | 142.7 | 195.1 |

## 测新 GPU 后的操作步骤

详见 [nvidia/GPU_TEST_CHECKLIST.md](nvidia/GPU_TEST_CHECKLIST.md)

## 环境要求

- NVIDIA: CUDA Toolkit 13.0+, NVIDIA 驱动
- AMD: ROCm 6.0+（待实现）
