Dense GPU GEMM Benchmark
Generated: 2026-10-25T06:59:53.278+00:00
Driver: 615.78.08
CUDA compiler: Cuda compilation tools, release 13.3, V13.3.73
Dense only: no 2:4 sparsity or sparse GEMM APIs

[isolated]
GPU 0: NVIDIA GeForce RTX 3090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           2048       30.394                0.57 TFLOPS   PASS
  fp32           8192       36.696               29.96 TFLOPS   PASS
  tf32           8192       26.712               41.16 TFLOPS   PASS
  bf16           16384      106.325              82.73 TFLOPS   PASS
  fp16           16384      106.726              82.42 TFLOPS   PASS
  int8           16384      28.717              306.30 TOPS     PASS
  int4           0          0.000               657.50 TOPS     OK
  bf16_mma       0          0.000                83.02 TFLOPS   OK
  int8_mma       0          0.000               329.59 TFLOPS   OK

[concurrent]
GPU 0: NVIDIA GeForce RTX 3090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       828.573               0.56 TFLOPS   PASS
  fp32           8192       37.003               29.71 TFLOPS   PASS
  tf32           8192       26.829               40.98 TFLOPS   PASS
  bf16           16384      106.720              82.42 TFLOPS   PASS
  fp16           16384      106.701              82.44 TFLOPS   PASS
  int8           16384      28.809              305.33 TOPS     PASS
  int4           0          0.000               657.61 TOPS     OK
  bf16_mma       0          0.000                82.78 TFLOPS   OK
  int8_mma       0          0.000               329.77 TFLOPS   OK

  Concurrent aggregate:
    fp64                 0.56 TFLOPS
    fp32                29.71 TFLOPS
    tf32                40.98 TFLOPS
    bf16                82.42 TFLOPS
    fp16                82.44 TFLOPS
    int8               305.33 TOPS
    int4               657.61 TOPS
    bf16_mma            82.78 TFLOPS
    int8_mma           329.77 TFLOPS

[UNSUPPORTED / SKIPPED]
  isolated GPU 0 fp8_e4m3: UNSUPPORTED - Requires compute capability 8.9 or newer; device is 8.6
  isolated GPU 0 fp8_e4m3_mma: UNSUPPORTED - 
  isolated GPU 0 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.6
  isolated GPU 0 fp4_e2m1: UNSUPPORTED - 
  concurrent GPU 0 fp8_e4m3: UNSUPPORTED - Requires compute capability 8.9 or newer; device is 8.6
  concurrent GPU 0 fp8_e4m3_mma: UNSUPPORTED - 
  concurrent GPU 0 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.6
  concurrent GPU 0 fp4_e2m1: UNSUPPORTED - 

