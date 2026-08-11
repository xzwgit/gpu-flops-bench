# AMD GPU Dense GEMM Benchmark (ROCm)

> 待实现。测试 AMD Instinct (MI300X 等) 的 dense GEMM FLOPS。
> 将使用 hipBLASLt / rocBLAS，输出格式与 NVIDIA 版对齐。

## 计划

- 工具: hipBLASLt benchmark 或 rocBLAS bench
- 精度: FP64 / FP32 / BF16 / FP16 / INT8 / FP8
- 编译: hipcc
- 输出: report.md / report.csv / report.json (与 NVIDIA 版统一格式)

## 待测 GPU

| GPU | 架构 | 状态 |
|---|---|---|
| AMD Instinct MI300X | CDNA3 | 待测 |
