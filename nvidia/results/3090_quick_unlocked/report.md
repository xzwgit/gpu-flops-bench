Dense GPU GEMM Benchmark
Generated: 2026-10-25T09:45:04.255+00:00
Driver: 615.78.08
CUDA compiler: Cuda compilation tools, release 13.3, V13.3.73
Dense only: no 2:4 sparsity or sparse GEMM APIs

[isolated]
GPU 0: NVIDIA GeForce RTX 3090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           4096       244.801               0.56 TFLOPS   PASS
  fp32           8192       36.537               30.09 TFLOPS   PASS
  tf32           8192       14.073               78.13 TFLOPS   PASS
  bf16           8192       7.507               146.47 TFLOPS   PASS
  fp16           8192       7.446               147.67 TFLOPS   PASS
  int8           8192       3.656               300.70 TOPS     PASS
  int4           0          0.000               666.29 TOPS     OK
  bf16_mma       0          0.000               166.88 TFLOPS   OK
  int8_mma       0          0.000               333.81 TFLOPS   OK

[concurrent]
GPU 0: NVIDIA GeForce RTX 3090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           4096       246.752               0.56 TFLOPS   PASS
  fp32           8192       36.422               30.19 TFLOPS   PASS
  tf32           8192       14.177               77.55 TFLOPS   PASS
  bf16           8192       7.513               146.35 TFLOPS   PASS
  fp16           8192       7.505               146.51 TFLOPS   PASS
  int8           8192       3.659               300.52 TOPS     PASS
  int4           0          0.000               666.03 TOPS     OK
  bf16_mma       0          0.000               166.80 TFLOPS   OK
  int8_mma       0          0.000               333.60 TFLOPS   OK

  Concurrent aggregate:
    fp64                 0.56 TFLOPS
    fp32                30.19 TFLOPS
    tf32                77.55 TFLOPS
    bf16               146.35 TFLOPS
    fp16               146.51 TFLOPS
    int8               300.52 TOPS
    int4               666.03 TOPS
    bf16_mma           166.80 TFLOPS
    int8_mma           333.60 TFLOPS

[UNSUPPORTED / SKIPPED]
  isolated GPU 0 fp8_e4m3: UNSUPPORTED - Requires compute capability 8.9 or newer; device is 8.6
  isolated GPU 0 fp8_e4m3_mma: UNSUPPORTED - 
  isolated GPU 0 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.6
  isolated GPU 0 fp4_e2m1: UNSUPPORTED - 
  concurrent GPU 0 fp8_e4m3: UNSUPPORTED - Requires compute capability 8.9 or newer; device is 8.6
  concurrent GPU 0 fp8_e4m3_mma: UNSUPPORTED - 
  concurrent GPU 0 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.6
  concurrent GPU 0 fp4_e2m1: UNSUPPORTED - 

