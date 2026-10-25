Dense GPU GEMM Benchmark
Generated: 2026-10-25T09:51:29.559+00:00
Driver: 615.78.08
CUDA compiler: Cuda compilation tools, release 13.3, V13.3.73
Dense only: no 2:4 sparsity or sparse GEMM APIs

[isolated]
GPU 0: NVIDIA GeForce RTX 3090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           4096       244.934               0.56 TFLOPS   PASS
  fp32           8192       36.390               30.21 TFLOPS   PASS
  tf32           8192       26.511               41.47 TFLOPS   PASS
  bf16           8192       13.296               82.70 TFLOPS   PASS
  fp16           8192       13.202               83.28 TFLOPS   PASS
  int8           8192       3.659               300.52 TOPS     PASS
  int4           0          0.000               666.24 TOPS     OK
  bf16_mma       0          0.000                83.64 TFLOPS   OK
  int8_mma       0          0.000               333.60 TFLOPS   OK

[concurrent]
GPU 0: NVIDIA GeForce RTX 3090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           4096       244.796               0.56 TFLOPS   PASS
  fp32           8192       36.706               29.95 TFLOPS   PASS
  tf32           8192       26.649               41.26 TFLOPS   PASS
  bf16           8192       13.397               82.07 TFLOPS   PASS
  fp16           8192       13.296               82.70 TFLOPS   PASS
  int8           8192       3.682               298.59 TOPS     PASS
  int4           0          0.000               661.72 TOPS     OK
  bf16_mma       0          0.000                83.26 TFLOPS   OK
  int8_mma       0          0.000               331.54 TFLOPS   OK

  Concurrent aggregate:
    fp64                 0.56 TFLOPS
    fp32                29.95 TFLOPS
    tf32                41.26 TFLOPS
    bf16                82.07 TFLOPS
    fp16                82.70 TFLOPS
    int8               298.59 TOPS
    int4               661.72 TOPS
    bf16_mma            83.26 TFLOPS
    int8_mma           331.54 TFLOPS

[UNSUPPORTED / SKIPPED]
  isolated GPU 0 fp8_e4m3: UNSUPPORTED - Requires compute capability 8.9 or newer; device is 8.6
  isolated GPU 0 fp8_e4m3_mma: UNSUPPORTED - 
  isolated GPU 0 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.6
  isolated GPU 0 fp4_e2m1: UNSUPPORTED - 
  concurrent GPU 0 fp8_e4m3: UNSUPPORTED - Requires compute capability 8.9 or newer; device is 8.6
  concurrent GPU 0 fp8_e4m3_mma: UNSUPPORTED - 
  concurrent GPU 0 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.6
  concurrent GPU 0 fp4_e2m1: UNSUPPORTED - 

