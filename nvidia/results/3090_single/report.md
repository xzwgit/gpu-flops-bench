Dense GPU GEMM Benchmark
Generated: 2026-10-06T04:04:03.656+00:00
Driver: 595.91.07
CUDA compiler: Cuda compilation tools, release 13.3, V13.3.73
Dense only: no 2:4 sparsity or sparse GEMM APIs

[isolated]
GPU 0: NVIDIA GeForce RTX 3090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           2048       30.386                0.57 TFLOPS   PASS
  fp32           8192       36.558               30.08 TFLOPS   PASS
  tf32           8192       26.664               41.24 TFLOPS   PASS
  bf16           16384      106.080              82.92 TFLOPS   PASS
  fp16           16384      106.383              82.68 TFLOPS   PASS
  int8           16384      28.615              307.40 TOPS     PASS
  int4           0          0.000               661.00 TOPS     OK
  bf16_mma       0          0.000                83.16 TFLOPS   OK
  int8_mma       0          0.000               331.01 TFLOPS   OK

[concurrent]
GPU 0: NVIDIA GeForce RTX 3090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       826.198               0.56 TFLOPS   PASS
  fp32           8192       36.819               29.86 TFLOPS   PASS
  tf32           8192       26.767               41.08 TFLOPS   PASS
  bf16           16384      106.403              82.67 TFLOPS   PASS
  fp16           16384      106.380              82.69 TFLOPS   PASS
  int8           16384      28.808              305.33 TOPS     PASS
  int4           0          0.000               661.00 TOPS     OK
  bf16_mma       0          0.000                82.99 TFLOPS   OK
  int8_mma       0          0.000               331.08 TFLOPS   OK

  Concurrent aggregate:
    fp64                 0.56 TFLOPS
    fp32                29.86 TFLOPS
    tf32                41.08 TFLOPS
    bf16                82.67 TFLOPS
    fp16                82.69 TFLOPS
    int8               305.33 TOPS
    int4               661.00 TOPS
    bf16_mma            82.99 TFLOPS
    int8_mma           331.08 TFLOPS

[UNSUPPORTED / SKIPPED]
  isolated GPU 0 fp8_e4m3: UNSUPPORTED - Requires compute capability 8.9 or newer; device is 8.6
  isolated GPU 0 fp8_e4m3_mma: UNSUPPORTED - 
  isolated GPU 0 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.6
  isolated GPU 0 fp4_e2m1: UNSUPPORTED - 
  concurrent GPU 0 fp8_e4m3: UNSUPPORTED - Requires compute capability 8.9 or newer; device is 8.6
  concurrent GPU 0 fp8_e4m3_mma: UNSUPPORTED - 
  concurrent GPU 0 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.6
  concurrent GPU 0 fp4_e2m1: UNSUPPORTED - 

