Dense GPU GEMM Benchmark
Generated: 2026-08-15T12:03:05.318+00:00
Driver: 580.105.08
CUDA compiler: Cuda compilation tools, release 13.0, V13.0.88
Dense only: no 2:4 sparsity or sparse GEMM APIs

[isolated]
GPU 0: NVIDIA RTX 6000D
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       351.515               1.32 TFLOPS   PASS
  fp32           8192       16.283               67.52 TFLOPS   PASS
  tf32           12288      51.355               72.26 TFLOPS   PASS
  bf16           8192       7.304               150.53 TFLOPS   PASS
  fp16           8192       7.328               150.03 TFLOPS   PASS
  int8           4096       0.351               391.06 TOPS     PASS
  fp8_e4m3       4096       0.477               287.89 TFLOPS   PASS
  nvfp4          4096       0.145               946.03 TFLOPS   PASS

[UNSUPPORTED / SKIPPED]
  isolated GPU 0 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs

