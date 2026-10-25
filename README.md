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

### NVIDIA（11 款，按算力从高到低排序）

| <small>GPU</small> | <small>架构</small> | <small>CC</small> | <small>显存</small> | <small>FP64</small> | <small>FP32</small> | <small>TF32</small> | <small>BF16</small> | <small>FP16</small> | <small>INT8</small> | <small>E4M3</small> | <small>NVFP4</small> |
|---|---|---|---|---|---|---|---|---|---|---|---|
| <small>B300&nbsp;SXM6</small> | <small>Blackwell</small> | <small>10.3</small> | <small>275G</small> | <small>1.05</small> | <small>68.8</small> | <small>1101</small> | <small>2235</small> | <small>2235</small> | <small>151</small> | <small>4377</small> | <small>10441</small> |
| <small>H200&nbsp;NVL</small> | <small>Hopper</small> | <small>9.0</small> | <small>141G</small> | <small>59.0</small> | <small>47.3</small> | <small>426</small> | <small>853</small> | <small>854</small> | <small>1630</small> | <small>1661</small> | <small>—</small> |
| <small>RTX&nbsp;PRO&nbsp;6000</small> | <small>Blackwell</small> | <small>12.0</small> | <small>96G</small> | <small>1.5</small> | <small>83.6</small> | <small>225</small> | <small>458</small> | <small>457</small> | <small>845</small> | <small>905</small> | <small>1608</small> |
| <small>RTX&nbsp;5090</small> | <small>Blackwell</small> | <small>12.0</small> | <small>32G</small> | <small>1.8</small> | <small>83.2</small> | <small>126</small> | <small>254</small> | <small>254</small> | <small>906</small> | <small>774</small> | <small>1617</small> |
| <small>RTX&nbsp;PRO&nbsp;5000</small> | <small>Blackwell</small> | <small>12.0</small> | <small>48G</small> | <small>1.0</small> | <small>52.4</small> | <small>140</small> | <small>257</small> | <small>260</small> | <small>552</small> | <small>557</small> | <small>1064</small> |
| <small>RTX&nbsp;5090&nbsp;D&nbsp;v2</small> | <small>Blackwell</small> | <small>12.0</small> | <small>24G</small> | <small>1.7</small> | <small>83.7</small> | <small>119</small> | <small>241</small> | <small>241</small> | <small>665</small> | <small>661</small> | <small>1177</small> |
| <small>RTX&nbsp;6000D</small> | <small>Blackwell</small> | <small>12.0</small> | <small>84G</small> | <small>1.3</small> | <small>67.5</small> | <small>72</small> | <small>151</small> | <small>150</small> | <small>391</small> | <small>288</small> | <small>946</small> |
| <small>RTX&nbsp;4090</small> | <small>Ada&nbsp;Lovelace</small> | <small>8.9</small> | <small>24G</small> | <small>1.3</small> | <small>57.6</small> | <small>90</small> | <small>179</small> | <small>179</small> | <small>676</small> | <small>354</small> | <small>—</small> |
| <small>GB10&nbsp;(Spark)</small> | <small>Grace&nbsp;Blackwell</small> | <small>12.1</small> | <small>128G</small> | <small>0.4</small> | <small>21.2</small> | <small>43</small> | <small>102</small> | <small>105</small> | <small>155</small> | <small>220</small> | <small>373</small> |
| <small>RTX&nbsp;3090</small> | <small>Ampere</small> | <small>8.6</small> | <small>24G</small> | <small>0.57</small> | <small>30.1</small> | <small>41</small> | <small>83</small> | <small>83</small> | <small>307</small> | <small>—</small> | <small>—</small> |
| <small>RTX&nbsp;3060</small> | <small>Ampere</small> | <small>8.6</small> | <small>12G</small> | <small>0.2</small> | <small>10.3</small> | <small>13</small> | <small>27</small> | <small>27</small> | <small>95</small> | <small>—</small> | <small>—</small> |

> 单位: TFLOPS（INT8 为 TOPS）  GB10 为统一内存（CPU+GPU 共享）
> 数据为 cuBLASLt dense GEMM 实测值（非稀疏，isolated 隔离测试）
> 完整精度数据见 [GPU_TEST_CHECKLIST.md](nvidia/GPU_TEST_CHECKLIST.md)

### v2 版（新增检测维度：mma.sync 与 GEMM (cuBLASLt) 双列）

> 2026-10-04 用本工具 v2 在 B300 8 卡、PRO 6000 和 RTX 6000D 上实测。GEMM 列走 cuBLASLt（tcgen05 dispatch），mma 列走 mma.sync 内核（legacy warp-level）。2026-10-06 补充 RTX 3090（SM86）与 RTX 4090（SM89，8 卡实测）。

| <small>GPU</small> | <small>架构</small> | <small>CC</small> | <small>显存</small> | <small>FP64</small> | <small>FP32</small> | <small>TF32</small> | <small>BF16</small> | <small>BF16<br>mma</small> | <small>FP16</small> | <small>INT8</small> | <small>FP8<br>E4M3</small> | <small>FP8<br>E4M3 mma</small> | <small>NVFP4</small> | <small>INT4</small> | <small>FP4<br>E2M1</small> |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| <small>B300&nbsp;SXM6&nbsp;AC</small> | <small>SM103</small> | <small>10.3</small> | <small>275G</small> | <small>1.05</small> | <small>68.8</small> | <small>**1101**</small> | <small>**2235**</small> | <small>551</small> | <small>**2235**</small> | <small>151</small> | <small>**4377**</small> | <small>1958</small> | <small>**10441**</small> | <small>74</small> | <small>N/A</small> |
| <small>RTX&nbsp;PRO&nbsp;6000</small> | <small>SM120</small> | <small>12.0</small> | <small>96G</small> | <small>1.53</small> | <small>80.6</small> | <small>225</small> | <small>**457**</small> | <small>462</small> | <small>457</small> | <small>882</small> | <small>**906**</small> | <small>924</small> | <small>**1619**</small> | <small>235</small> | <small>924</small> |
| <small>RTX&nbsp;6000D</small> | <small>SM120</small> | <small>12.0</small> | <small>84G</small> | <small>1.28</small> | <small>66.7</small> | <small>72</small> | <small>**176**</small> | <small>146</small> | <small>144</small> | <small>472</small> | <small>**386**</small> | <small>291</small> | <small>**947**</small> | <small>141</small> | <small>379</small> |
| <small>RTX&nbsp;3090</small> | <small>SM86</small> | <small>8.6</small> | <small>24G</small> | <small>0.57</small> | <small>30.1</small> | <small>41</small> | <small>**83**</small> | <small>83</small> | <small>83</small> | <small>307</small> | <small>N/A</small> | <small>N/A</small> | <small>N/A</small> | <small>661</small> | <small>N/A</small> |
| <small>RTX&nbsp;4090</small> | <small>SM89</small> | <small>8.9</small> | <small>24G</small> | <small>1.25</small> | <small>57.2</small> | <small>89</small> | <small>**178**</small> | <small>181</small> | <small>175</small> | <small>672</small> | <small>**352**</small> | <small>360</small> | <small>N/A</small> | <small>1434</small> | <small>N/A</small> |

> 单位: TFLOPS（INT8/INT4 为 TOPS）
> B300 8 卡一致性：BF16 2233-2235、NVFP4 10360-10476（±0.2%）；8 卡 concurrent 聚合线性度≥99.7%
>
> **架构发现**：
> - **SM120 (PRO 6000) 上 mma.sync ≈ GEMM（满速）**：BF16 462 vs 457、FP8 924 vs 906——消费级 Blackwell 的 mma.sync 与 cuBLASLt 走同一硬件路径
> - **RTX 6000D（SM120 出口版，156 SM，驱动 590.48.01）**：mma/GEMM 比值 BF16 0.83（146/176）、FP8 0.75（291/386）——低于 PRO 6000 的 ≈1.0，仍远高于 B300 的 0.25~0.45，落在 SM120 模式内。该卡 INT8 (472) > FP8 (386)、BF16 (176) > FP16 (144)，排序与 PRO 6000 相反；NVFP4 947 为该卡最高吞吐。BF16 176 与 2026-08 另一台 RTX 6000D 的 v1 实测 151 同量级（两台不同机器独立复现）
> - **SM103 (B300) 上 mma.sync 只有 GEMM 的 25-45%**：BF16 551 vs 2235 (25%)、FP8 1958 vs 4377 (45%)——数据中心 Blackwell 需 tcgen05.mma（cuBLASLt dispatch），mma.sync 是 legacy 降档路径
> - **B300 INT8 = 151 TOPS（所有标准 API 路径一致：mma.sync ≈ cuBLASLt INT32I ≈ 149-152）**，远低于 FP8 的 4377。硬件 spec INT8 ≈ FP8 ≈ 4500 TOPS（同一 8-bit tensor core），纯粹是 **cuBLASLt 未给 INT8 dispatch tcgen05**。实际 8-bit 推理推荐用 FP8 E4M3 替代（同一硬件，29× 快于 INT32I）
> - **B300 低精度整数全面弱项**：INT8 = 151 TOPS（vs PRO 6000 的 882，仅 17%）、**INT4 = 74 TOPS（vs PRO 6000 的 235，仅 31%）**——SM103 上低精度整数（INT8/INT4）的 mma.sync 和 cuBLASLt 路径均无 tcgen05 dispatch，与 BF16/FP8 高精度路径形成鲜明对比。8-bit 以下量化推理在 B300 上应用 FP8 E4M3（4377 TFLOPS）或 NVFP4（10441 TFLOPS）替代
> - **FP4 E2M1**：PRO 6000 有值 924（CC 12.0 的 mma.sync kind::f8f6f4），B300 N/A（CC 10.3）
> - **RTX 3090（SM86，2026-10-06 补测）**：BF16 GEMM ≈ mma（83 ≈ 83）——Ampere 与 SM120 一样 mma.sync 满速，legacy 路径不降档；**INT4 661 = 2× INT8 GEMM（307）**，Ampere 时代 INT4 仍是满速加速路径（对照 SM120 的 INT4 235/141、SM103 的 74 全面降速）；FP8/NVFP4/FP4 需 CC 8.9+/12.0+，均 N/A；FP32 走 SGEMM 30.1（访存受限，低于理论 FMA 峰值属正常口径差异）
> - **RTX 4090（SM89，128 SM，8 卡一致性 ±1.7%）**：mma/GEMM 比值 BF16 1.02（181/178）、FP8 1.02（360/352）——**Ada 与 Ampere/SM120 同属"mma.sync 满速"阵营，四代里只有数据中心 SM103 把 legacy 路径降档**。**INT4 mma = 1434 TOPS ≈ 2.1× 其 INT8（672）**——Ada 延续 4-bit 传统 2× 收益，至此三代对照完整：Ampere 661（2.2×）/Ada 1434（2.1×）/**Blackwell 74~235（0.08~0.27×，INT4 mma 快路径在 Blackwell 上被砍掉两个数量级，低比特整数全面让位 FP8/NVFP4）**。NVFP4/FP4 E2M1 在 SM89 均无路径（N/A）
> - INT8 F32acc（混合精度）在 B300 上仅 40 TOPS，比 INT32I 还差——证实不是计算类型问题，是 INT8 整体无 tcgen05 路径

### Tensor 发射限速解锁（RTX 4090 48G · RTX 3090，2026-10-25）

> 测试机：8 × RTX 4090 48G（改装，10de:2684，驱动 595.71.05，CUDA 13.2），
> GPU 侧 FEAT_OVR_PLM 的 SM 发射率限制（FP16/BF16/TF32 Tensor 路径限半速
> 档位）已解除。GEMM 列为 cuBLASLt isolated 单卡中位数（矩阵 8192³，FP64 为
> 4096³，`--quick`）；mma 列为 mma.sync 发射率内核（`--precisions *_mma` /
> `int4`）。v2 表的 RTX 4090（24G 零售卡）为未解锁参考：
> 另一台测试机：单卡 RTX 3090（GA102 零售卡，ASUS，功耗墙 390W，驱动
> 615.78.08，CUDA 13.3），gpu-unlock v1.0.0 同机冷启动切换锁定/解锁做 A/B，
> 口径同上（GEMM 8192³ 完整模式，FP64 6144³）：

| <small>GPU</small> | <small>架构</small> | <small>CC</small> | <small>显存</small> | <small>FP64</small> | <small>FP32</small> | <small>TF32</small> | <small>BF16</small> | <small>BF16<br>mma</small> | <small>FP16</small> | <small>INT8</small> | <small>FP8<br>E4M3</small> | <small>FP8<br>E4M3 mma</small> | <small>NVFP4</small> | <small>INT4</small> | <small>FP4<br>E2M1</small> |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| <small>RTX&nbsp;4090&nbsp;48G&nbsp;解锁</small> | <small>SM89</small> | <small>8.9</small> | <small>48G</small> | <small>1.2</small> | <small>56.7</small> | <small>151</small> | <small>191</small> | <small>346</small> | <small>233</small> | <small>608</small> | <small>526</small> | <small>715</small> | <small>N/A</small> | <small>1428</small> | <small>N/A</small> |
| <small>RTX&nbsp;3090&nbsp;锁定</small> | <small>SM86</small> | <small>8.6</small> | <small>24G</small> | <small>0.56</small> | <small>30.1</small> | <small>41</small> | <small>82</small> | <small>83</small> | <small>82</small> | <small>296</small> | <small>N/A</small> | <small>N/A</small> | <small>N/A</small> | <small>661</small> | <small>N/A</small> |
| <small>RTX&nbsp;3090&nbsp;解锁</small> | <small>SM86</small> | <small>8.6</small> | <small>24G</small> | <small>0.57</small> | <small>30.0</small> | <small>77</small> | <small>144</small> | <small>165</small> | <small>145</small> | <small>294</small> | <small>N/A</small> | <small>N/A</small> | <small>N/A</small> | <small>661</small> | <small>N/A</small> |

> 单位: TFLOPS（INT8/INT4 为 TOPS）
> 相对未解锁参考（v2 表 24G 零售卡）：GEMM 列 TF32 89→151、FP16 175→233、
> BF16 178→191、E4M3 352→526；mma 列 BF16 181→346（×1.9）、E4M3 360→715
> （×2.0）——发射率层面 ×2 复现，GEMM 层面受功率墙只兑现一部分。INT8
> 672→608、INT4 1434→1428、FP64/FP32 变化在跨机（48G 改装 vs 24G 零售）
> 差异范围内，整数与 CUDA Core 路径不受该发射限制影响。NVFP4/FP4 E2M1
> 在 SM89 无路径（N/A）。
> RTX 3090 解锁 vs 锁定（同机同日，GEMM 列取完整模式 8192³ 行，与 4090 行
> 口径一致）：GEMM 列 TF32 41→77（×1.87）、BF16 82→144（×1.76）、FP16
> 82→145（×1.77）；解锁态 16384³ 时 BF16/FP16 可达 158/159（×1.9，解锁后
> 大矩阵更优）。mma 列 BF16 83→165（×2.0）。对照组 FP64/FP32/INT8
> （296→294）/INT8 mma（331→331）/INT4（661→661）持平，输出校验全部
> PASS。FP8/NVFP4/FP4 E2M1 在 SM86 无路径（N/A）。
> 2026-10-25 晚独立 quick 复测（`--quick`，两次冷启动切换两态）完全复现：
> TF32 ×1.88、BF16 GEMM ×1.76、BF16 mma ×1.99、INT8/INT4/INT8 mma 持平，
> 与已登记值差 ≤±2.4%（quick 与完整模式的固有噪声）。数据见
> `nvidia/results/3090_quick_locked/`、`3090_quick_unlocked/` 及比对说明。
> 解锁操作与同机 A/B 实录存内部私有仓，此处仅登记实测结果。

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
