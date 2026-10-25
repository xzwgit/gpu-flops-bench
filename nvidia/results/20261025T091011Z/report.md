Dense GPU GEMM Benchmark
Generated: 2026-10-25T09:13:12.723+00:00
Driver: 615.78.08
CUDA compiler: Cuda compilation tools, release 13.3, V13.3.73
Dense only: no 2:4 sparsity or sparse GEMM APIs

[isolated]
GPU 0: NVIDIA GeForce RTX 3090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       819.981               0.57 TFLOPS   PASS
  fp32           8192       36.708               29.95 TFLOPS   PASS
  tf32           8192       14.292               76.93 TFLOPS   PASS
  bf16           16384      55.598              158.21 TFLOPS   PASS
  fp16           16384      55.316              159.01 TFLOPS   PASS
  int8           16384      28.609              307.46 TOPS     PASS
  int4           0          0.000               660.99 TOPS     OK
  bf16_mma       0          0.000               165.49 TFLOPS   OK
  int8_mma       0          0.000               331.02 TFLOPS   OK

[concurrent]
GPU 0: NVIDIA GeForce RTX 3090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       826.185               0.56 TFLOPS   PASS
  fp32           8192       36.867               29.82 TFLOPS   PASS
  tf32           8192       14.355               76.59 TFLOPS   PASS
  bf16           16384      55.628              158.12 TFLOPS   PASS
  fp16           16384      55.567              158.30 TFLOPS   PASS
  int8           16384      28.820              305.20 TOPS     PASS
  int4           0          0.000               656.00 TOPS     OK
  bf16_mma       0          0.000               164.24 TFLOPS   OK
  int8_mma       0          0.000               328.58 TFLOPS   OK

  Concurrent aggregate:
    fp64                 0.56 TFLOPS
    fp32                29.82 TFLOPS
    tf32                76.59 TFLOPS
    bf16               158.12 TFLOPS
    fp16               158.30 TFLOPS
    int8               305.20 TOPS
    int4               656.00 TOPS
    bf16_mma           164.24 TFLOPS
    int8_mma           328.58 TFLOPS

[UNSUPPORTED / SKIPPED]
  isolated GPU 0 fp8_e4m3: UNSUPPORTED - Requires compute capability 8.9 or newer; device is 8.6
  isolated GPU 0 fp8_e4m3_mma: UNSUPPORTED - 
  isolated GPU 0 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.6
  isolated GPU 0 fp4_e2m1: UNSUPPORTED - 
  concurrent GPU 0 fp8_e4m3: UNSUPPORTED - Requires compute capability 8.9 or newer; device is 8.6
  concurrent GPU 0 fp8_e4m3_mma: UNSUPPORTED - 
  concurrent GPU 0 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.6
  concurrent GPU 0 fp4_e2m1: UNSUPPORTED - 

