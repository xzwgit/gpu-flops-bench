Dense GPU GEMM Benchmark
Generated: 2026-08-11T02:36:05.650+00:00
Driver: 580.105.08
CUDA compiler: Cuda compilation tools, release 13.0, V13.0.88
Dense only: no 2:4 sparsity or sparse GEMM APIs

[isolated]
GPU 0: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       381.126               1.22 TFLOPS   PASS
  fp32           8192       19.606               56.08 TFLOPS   PASS
  tf32           12288      42.187               87.96 TFLOPS   PASS
  bf16           4096       0.788               174.31 TFLOPS   PASS
  fp16           4096       0.792               173.63 TFLOPS   PASS
  int8           16384      13.302              661.27 TOPS     PASS
  fp8_e4m3       16384      25.474              345.30 TFLOPS   PASS

GPU 1: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       379.168               1.22 TFLOPS   PASS
  fp32           8192       19.352               56.82 TFLOPS   PASS
  tf32           12288      42.051               88.25 TFLOPS   PASS
  bf16           4096       0.786               174.76 TFLOPS   PASS
  fp16           4096       0.785               174.99 TFLOPS   PASS
  int8           16384      13.150              668.89 TOPS     PASS
  fp8_e4m3       16384      25.316              347.45 TFLOPS   PASS

GPU 2: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       379.545               1.22 TFLOPS   PASS
  fp32           8192       19.531               56.30 TFLOPS   PASS
  tf32           12288      41.953               88.45 TFLOPS   PASS
  bf16           4096       0.783               175.45 TFLOPS   PASS
  fp16           4096       0.788               174.51 TFLOPS   PASS
  int8           16384      13.222              665.28 TOPS     PASS
  fp8_e4m3       16384      25.292              347.78 TFLOPS   PASS

GPU 3: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       374.404               1.24 TFLOPS   PASS
  fp32           8192       19.227               57.19 TFLOPS   PASS
  tf32           12288      41.348               89.75 TFLOPS   PASS
  bf16           4096       0.772               178.04 TFLOPS   PASS
  fp16           8192       6.259               175.68 TFLOPS   PASS
  int8           16384      13.085              672.25 TOPS     PASS
  fp8_e4m3       16384      24.896              353.31 TFLOPS   PASS

GPU 4: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       377.162               1.23 TFLOPS   PASS
  fp32           8192       19.404               56.66 TFLOPS   PASS
  tf32           12288      41.726               88.93 TFLOPS   PASS
  bf16           4096       0.778               176.56 TFLOPS   PASS
  fp16           8192       6.325               173.82 TFLOPS   PASS
  int8           16384      13.151              668.83 TOPS     PASS
  fp8_e4m3       16384      25.127              350.07 TFLOPS   PASS

GPU 5: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       379.384               1.22 TFLOPS   PASS
  fp32           8192       19.491               56.41 TFLOPS   PASS
  tf32           12288      42.030               88.29 TFLOPS   PASS
  bf16           4096       0.784               175.22 TFLOPS   PASS
  fp16           4096       0.785               174.99 TFLOPS   PASS
  int8           16384      13.158              668.48 TOPS     PASS
  fp8_e4m3       16384      25.342              347.09 TFLOPS   PASS

GPU 6: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       371.618               1.25 TFLOPS   PASS
  fp32           8192       19.104               57.55 TFLOPS   PASS
  tf32           12288      41.072               90.35 TFLOPS   PASS
  bf16           4096       0.767               179.20 TFLOPS   PASS
  fp16           4096       0.767               179.20 TFLOPS   PASS
  int8           16384      13.075              672.72 TOPS     PASS
  fp8_e4m3       16384      24.832              354.22 TFLOPS   PASS

GPU 7: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       397.634               1.17 TFLOPS   PASS
  fp32           8192       20.132               54.62 TFLOPS   PASS
  tf32           12288      44.199               83.96 TFLOPS   PASS
  bf16           4096       0.822               167.13 TFLOPS   PASS
  fp16           8192       6.537               168.19 TFLOPS   PASS
  int8           16384      13.618              645.91 TOPS     PASS
  fp8_e4m3       8192       3.299               333.26 TFLOPS   PASS

[concurrent]
GPU 0: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       380.715               1.22 TFLOPS   PASS
  fp32           8192       19.604               56.08 TFLOPS   PASS
  tf32           12288      42.057               88.23 TFLOPS   PASS
  bf16           4096       0.793               173.34 TFLOPS   PASS
  fp16           8192       6.390               172.08 TFLOPS   PASS
  int8           16384      13.232              664.76 TOPS     PASS
  fp8_e4m3       16384      25.343              347.08 TFLOPS   PASS

GPU 1: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       379.004               1.22 TFLOPS   PASS
  fp32           8192       19.353               56.81 TFLOPS   PASS
  tf32           12288      42.015               88.32 TFLOPS   PASS
  bf16           4096       0.793               173.41 TFLOPS   PASS
  fp16           8192       6.324               173.85 TFLOPS   PASS
  int8           16384      13.092              671.88 TOPS     PASS
  fp8_e4m3       16384      25.246              348.42 TFLOPS   PASS

GPU 2: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       379.549               1.22 TFLOPS   PASS
  fp32           8192       19.387               56.71 TFLOPS   PASS
  tf32           12288      41.911               88.54 TFLOPS   PASS
  bf16           4096       0.783               175.45 TFLOPS   PASS
  fp16           4096       0.792               173.43 TFLOPS   PASS
  int8           16384      13.155              668.64 TOPS     PASS
  fp8_e4m3       16384      25.257              348.27 TFLOPS   PASS

GPU 3: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       373.211               1.24 TFLOPS   PASS
  fp32           8192       19.228               57.18 TFLOPS   PASS
  tf32           12288      41.284               89.89 TFLOPS   PASS
  bf16           4096       0.783               175.45 TFLOPS   PASS
  fp16           4096       0.777               176.84 TFLOPS   PASS
  int8           16384      13.012              676.00 TOPS     PASS
  fp8_e4m3       16384      24.901              353.24 TFLOPS   PASS

GPU 4: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       377.144               1.23 TFLOPS   PASS
  fp32           8192       19.395               56.69 TFLOPS   PASS
  tf32           12288      41.817               88.74 TFLOPS   PASS
  bf16           4096       0.787               174.68 TFLOPS   PASS
  fp16           8192       6.354               173.05 TFLOPS   PASS
  int8           16384      13.217              665.53 TOPS     PASS
  fp8_e4m3       16384      25.176              349.38 TFLOPS   PASS

GPU 5: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       379.372               1.22 TFLOPS   PASS
  fp32           8192       19.482               56.44 TFLOPS   PASS
  tf32           12288      42.073               88.20 TFLOPS   PASS
  bf16           4096       0.785               174.99 TFLOPS   PASS
  fp16           4096       0.788               174.31 TFLOPS   PASS
  int8           16384      13.229              664.91 TOPS     PASS
  fp8_e4m3       16384      25.373              346.68 TFLOPS   PASS

GPU 6: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       371.758               1.25 TFLOPS   PASS
  fp32           8192       19.106               57.55 TFLOPS   PASS
  tf32           12288      41.184               90.10 TFLOPS   PASS
  bf16           4096       0.767               179.20 TFLOPS   PASS
  fp16           4096       0.772               177.97 TFLOPS   PASS
  int8           16384      13.018              675.68 TOPS     PASS
  fp8_e4m3       16384      24.826              354.31 TFLOPS   PASS

GPU 7: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       399.745               1.16 TFLOPS   PASS
  fp32           8192       20.131               54.62 TFLOPS   PASS
  tf32           12288      44.304               83.76 TFLOPS   PASS
  bf16           4096       0.827               166.11 TFLOPS   PASS
  fp16           8192       6.575               167.22 TFLOPS   PASS
  int8           16384      13.626              645.52 TOPS     PASS
  fp8_e4m3       8192       3.309               332.32 TFLOPS   PASS

  Concurrent aggregate:
    fp64                 9.77 TFLOPS
    fp32               452.09 TFLOPS
    tf32               705.79 TFLOPS
    bf16              1392.62 TFLOPS
    fp16              1388.76 TFLOPS
    int8              5332.93 TOPS
    fp8_e4m3          2779.69 TFLOPS

[UNSUPPORTED / SKIPPED]
  isolated GPU 0 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  isolated GPU 0 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  isolated GPU 0 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  isolated GPU 1 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  isolated GPU 1 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  isolated GPU 1 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  isolated GPU 2 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  isolated GPU 2 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  isolated GPU 2 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  isolated GPU 3 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  isolated GPU 3 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  isolated GPU 3 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  isolated GPU 4 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  isolated GPU 4 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  isolated GPU 4 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  isolated GPU 5 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  isolated GPU 5 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  isolated GPU 5 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  isolated GPU 6 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  isolated GPU 6 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  isolated GPU 6 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  isolated GPU 7 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  isolated GPU 7 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  isolated GPU 7 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  concurrent GPU 0 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  concurrent GPU 0 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  concurrent GPU 0 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  concurrent GPU 1 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  concurrent GPU 1 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  concurrent GPU 1 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  concurrent GPU 2 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  concurrent GPU 2 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  concurrent GPU 2 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  concurrent GPU 3 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  concurrent GPU 3 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  concurrent GPU 3 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  concurrent GPU 4 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  concurrent GPU 4 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  concurrent GPU 4 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  concurrent GPU 5 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  concurrent GPU 5 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  concurrent GPU 5 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  concurrent GPU 6 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  concurrent GPU 6 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  concurrent GPU 6 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  concurrent GPU 7 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  concurrent GPU 7 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  concurrent GPU 7 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9

