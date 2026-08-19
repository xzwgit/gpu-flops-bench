Dense GPU GEMM Benchmark
Generated: 2026-08-19T06:44:51.171+00:00
Driver: 580.173.02
CUDA compiler: Cuda compilation tools, release 13.0, V13.0.88
Dense only: no 2:4 sparsity or sparse GEMM APIs

[isolated]
GPU 0: NVIDIA GB10
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           4096       339.803               0.40 TFLOPS   PASS
  fp32           8192       51.766               21.24 TFLOPS   PASS
  tf32           4096       3.225                42.62 TFLOPS   PASS
  bf16           8192       10.782              101.98 TFLOPS   PASS
  fp16           16384      83.708              105.08 TFLOPS   PASS
  int8           8192       7.072               155.47 TOPS     PASS
  fp8_e4m3       8192       5.002               219.83 TFLOPS   PASS
  nvfp4          8192       2.951               372.54 TFLOPS   PASS

[UNSUPPORTED / SKIPPED]
  isolated GPU 0 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  isolated GPU 0 int8: SKIPPED - Matrix and workspace would use more than 75% of free GPU memory

