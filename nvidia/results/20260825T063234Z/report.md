Dense GPU GEMM Benchmark
Generated: 2026-08-25T06:37:19.385+00:00
Driver: 595.58.03
CUDA compiler: Cuda compilation tools, release 13.2, V13.2.78
Dense only: no 2:4 sparsity or sparse GEMM APIs

[isolated]
GPU 0: NVIDIA GeForce RTX 3060
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       2534.255              0.18 TFLOPS   PASS
  fp32           8192       106.690              10.31 TFLOPS   PASS
  tf32           12288      275.771              13.46 TFLOPS   PASS
  bf16           16384      324.243              27.13 TFLOPS   PASS
  fp16           16384      322.653              27.26 TFLOPS   PASS
  int8           8192       11.632               94.53 TOPS     PASS

[UNSUPPORTED / SKIPPED]
  isolated GPU 0 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  isolated GPU 0 fp8_e4m3: UNSUPPORTED - Requires compute capability 8.9 or newer; device is 8.6
  isolated GPU 0 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.6

