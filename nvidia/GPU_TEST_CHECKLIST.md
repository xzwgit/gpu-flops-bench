# GPU 测试检查清单

> 运行 gpu_flops_test 前查看此清单，确保所有已测 GPU 的数据都更新到 README。
> 测完新 GPU 后，把结果追加到此清单 + 更新 README 表格。

## 已测 GPU 总览 (11 款)

| # | GPU | 架构 | CC | 显存 | 测试日期 | 结果位置 |
|---|---|---|---|---|---|---|
| 1 | RTX 5090 | Blackwell | 12.0 | 32 GB | 2026-07 | results/ (历史) + README |
| 2 | RTX 5090 D v2 | Blackwell | 12.0 | 24 GB | 2026-07 | results/ (历史) + README |
| 3 | RTX PRO 6000 Blackwell Server | Blackwell | 12.0 | 96 GB | 2026-07 | results/ (历史) + README |
| 4 | **RTX PRO 5000 Blackwell** | Blackwell | 12.0 | 48 GB | **2026-08-07** | **results/20260807T081713Z/** |
| 5 | **NVIDIA H200 NVL** | Hopper | 9.0 | 141 GB | **2026-08-10** | **results/20260810T090857Z/** |
| 6 | **NVIDIA GeForce RTX 4090** | Ada Lovelace | 8.9 | 24 GB | **2026-08-11** | **results/20260811T022856Z/** |
| 7 | **NVIDIA RTX 6000D** | Blackwell | 12.0 | 84 GB | **2026-08-15** | **results/20260815T120216Z/** |
| 8 | **NVIDIA GB10 (DGX Spark)** | Grace Blackwell | 12.1 | 128 GB (统一内存) | **2026-08-19** | **results/20260819T064242Z/** |
| 9 | **NVIDIA GeForce RTX 3060** | Ampere | 8.6 | 12 GB | **2026-08-25** | **results/20260825T063234Z/** |
| 10 | **B300 SXM6 AC** | Blackwell (SM103) | 10.3 | 275 GB | **2026-10-04** | **results/ (v2 表) + README v2 表** |
| 11 | **NVIDIA GeForce RTX 3090** | Ampere | 8.6 | 24 GB | **2026-10-06** | **results/3090_single/ + README v2 表** |

## 各 GPU 性能速查 (单卡最佳, TFLOPS)

| 精度 | B300 (275G) | 5090 (32G) | 5090D v2 (24G) | PRO 6000 (96G) | PRO 5000 (48G) | H200 NVL (141G) | RTX 4090 (24G) | RTX 6000D (84G) | 3090 (24G) |
|---|---|---|---|---|---|---|---|---|---|
| FP64 | 1.05 | 1.77 | 1.68 | 1.54 | 1.01 | 58.98 | 1.25 | **1.32** | 0.57 |
| FP32 | 68.8 | 83.24 | 83.70 | 83.60 | 52.41 | 47.28 | 57.55 | **67.52** | 30.1 |
| TF32 | 1101 | 125.80 | 119.34 | 224.70 | 140.27 | 425.55 | 90.35 | **72.26** | 41 |
| BF16 | 2235 | 254.03 | 240.72 | 457.61 | 257.12 | 853.29 | 179.20 | **150.53** | 83 |
| FP16 | 2235 | 254.21 | 240.66 | 457.44 | 260.25 | 853.68 | 179.20 | **150.03** | 83 |
| INT8 | 151 | 906.14 | 665.27 | 845.39 | 551.88 | 1629.76 | 676.00 | **391.06** | 307 |
| FP8 E4M3 | 4377 | 773.52 | 660.66 | 905.32 | 557.34 | 1660.83 | 354.31 | **287.89** | N/A |
| FP8 E5M2 | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED |
| NVFP4 | 10441 | 1617.46 | 1177.03 | 1608.21 | 1063.53 | UNSUPPORTED | UNSUPPORTED | **946.03** | N/A |
| INT4 | 74 | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED | 661 |

## 测新 GPU 后的操作步骤 (别漏!)

1. [ ] 拉取结果到本机: `scp -r root@<GPU机>:/root/nv_gpu_flops_test/results/<timestamp> results/`
2. [ ] 提取各精度最佳值 (从 report.md)
3. [ ] **更新 README.md "测试过的 GPU"列表** (加一行)
4. [ ] **更新 README.md "实测性能数据"** (加一个表格)
5. [ ] **更新此清单** (加一行到上面的总览 + 速查表)
6. [ ] git commit + push

## 已知坑：矩阵尺寸口径（2026-10-25 实录，重要！）

**`--quick` 的每精度固定尺寸表改过版**：2026-08 的版本低精度（int8/fp8/nvfp4）用 **4096³**，
现行版本统一 **8192³**（fp64/int16 仍 4096）。本表"速查"和 README v1 表中 2026-08 批次的
低精度数值都是 4096³ 口径（如 6000D 的 int8 391/e4m3 288/nvfp4 946）。

2026-10-25 在 8×RTX 6000D（10.10.3.162，驱动 615.71.09）复测时，拿 8192³ 新数对 4096³
旧数，一度得出"低精度 -40% 回归"的误判。排查后驱动/CUDA(13.0 vs 13.4)/工具版本/功耗
（2370MHz 满频、仅 246W、32°C）全部排除，`nvfp4@4096=938` 原样复现历史 946/947——
纯属口径错位。

**低精度的尺寸敏感性实测（6000D，SM120）**：

| 精度 | 4096³ | 8192³ | 16384³ | 特征 |
|---|---|---|---|---|
| nvfp4 | 937.8 | 536.6 | 567.6 | 大矩阵 -43%（block-scaled 内核） |
| fp8_e4m3 | 511.9 | 284.1 | 291.9 | 大矩阵 -45%（且比 8 月的 288 翻倍） |
| int8 | 288.4 | 277.2 | 288.8 | 尺寸平坦 |

**规则**：
1. 横向对比任何低精度数字，先核对尺寸列；跨 8 月批次的历史值必须换算口径再比。
2. 选型/卡间对比跑全尺寸扫描（不带 `--quick`，看 report.csv 的完整曲线），别看单点。
3. 用 4096³ 低精度数估生产（如 LLM prefill）会高估（6000D 上 nvfp4 高估 1.75×），
   8192³ 更接近实际 prefill 形状；decode 是带宽瓶颈，与 TFLOPS 无关。
4. 6000D 另有卡间差异：bf16 本机 146-154 vs v2 表 176（另一台卡），其 SS0 fuse 值
   逐卡不同，跨机器对比低精度/int8 数字天然有 ±15% 摆动。

## 通则（按卡族）

### Blackwell 消费/工作站 (CC 12.0)
- FP8 E5M2: 全部 UNSUPPORTED (cuBLASLt 无稠密 GEMM 内核)
- 其他精度: 全部 PASS (FP64/FP32/TF32/BF16/FP16/INT8/FP8 E4M3/NVFP4)
- CUDA: 统一 13.0
- 驱动: 统一 580.105.08

### 数据中心 Blackwell (B300, CC 10.3, 2026-10-04 实测)
- INT8 cuBLASLt dense 仅 151 TOPS（SM103 无传统 INT8 fast path，建议 FP8 E4M3 替代）；mma.sync INT4 也仅 74 TOPS（消费 Blackwell 1434 的 1/19——低比特整数让位 FP8/NVFP4）
- NVFP4 10441 TFLOPS（8 卡一致性 ±0.5%）；BF16/FP16 GEMM 2235（tcgen05），mma.sync 仅 551（25%，无 tcgen05 的 legacy warp-level 路径）
- FP8 E5M2 UNSUPPORTED（与消费卡同）

### Ampere (SM86, 3090, 2026-10-06 实测)
- INT4 mma 661 TOPS = 2.2× 其 INT8 GEMM 307（legacy INT4 快路径，Blackwell 上不存在）
- FP8/NVFP4: UNSUPPORTED（架构无此单元）
