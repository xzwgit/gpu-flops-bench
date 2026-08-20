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

<table style="font-size:85%">
<tr><th>GPU</th><th>架构</th><th>CC</th><th>显存</th><th>FP64</th><th>FP32</th><th>TF32</th><th>BF16</th><th>FP16</th><th>INT8</th><th>FP8 E4M3</th><th>NVFP4</th></tr>
<tr><td>H200 NVL</td><td>Hopper</td><td>9.0</td><td>141 GB</td><td>58.98</td><td>47.28</td><td>425.55</td><td>853.29</td><td>853.68</td><td>1629.76</td><td>1660.83</td><td>—</td></tr>
<tr><td>RTX PRO 6000</td><td>Blackwell</td><td>12.0</td><td>96 GB</td><td>1.54</td><td>83.60</td><td>224.70</td><td>457.61</td><td>457.44</td><td>845.39</td><td>905.32</td><td>1608.21</td></tr>
<tr><td>RTX 5090</td><td>Blackwell</td><td>12.0</td><td>32 GB</td><td>1.77</td><td>83.24</td><td>125.80</td><td>254.03</td><td>254.21</td><td>906.14</td><td>773.52</td><td>1617.46</td></tr>
<tr><td>RTX PRO 5000</td><td>Blackwell</td><td>12.0</td><td>48 GB</td><td>1.01</td><td>52.41</td><td>140.27</td><td>257.12</td><td>260.25</td><td>551.88</td><td>557.34</td><td>1063.53</td></tr>
<tr><td>RTX 5090 D v2</td><td>Blackwell</td><td>12.0</td><td>24 GB</td><td>1.68</td><td>83.70</td><td>119.34</td><td>240.72</td><td>240.66</td><td>665.27</td><td>660.66</td><td>1177.03</td></tr>
<tr><td>RTX 6000D</td><td>Blackwell</td><td>12.0</td><td>84 GB</td><td>1.32</td><td>67.52</td><td>72.26</td><td>150.53</td><td>150.03</td><td>391.06</td><td>287.89</td><td>946.03</td></tr>
<tr><td>RTX 4090</td><td>Ada Lovelace</td><td>8.9</td><td>24 GB</td><td>1.25</td><td>57.55</td><td>90.35</td><td>179.20</td><td>179.20</td><td>676.00</td><td>354.31</td><td>—</td></tr>
<tr><td>GB10 (DGX Spark)</td><td>Grace Blackwell</td><td>12.1</td><td>128 GB*</td><td>0.40</td><td>21.24</td><td>42.62</td><td>101.98</td><td>105.08</td><td>155.47</td><td>219.83</td><td>372.54</td></tr>
</table>

> 单位: TFLOPS（INT8 为 TOPS）  \* GB10 为统一内存
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
