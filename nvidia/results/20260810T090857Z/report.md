Dense GPU GEMM Benchmark
Generated: 2026-08-10T09:09:50.668+00:00
Driver: 580.105.08
CUDA compiler: Cuda compilation tools, release 13.0, V13.0.88
Dense only: no 2:4 sparsity or sparse GEMM APIs

[isolated]
GPU 0: NVIDIA H200 NVL
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       7.869                58.94 TFLOPS   PASS
  fp32           12288      78.619               47.20 TFLOPS   PASS
  tf32           12288      8.731               425.03 TFLOPS   PASS
  bf16           16384      10.324              851.99 TFLOPS   PASS
  fp16           16384      10.333              851.24 TFLOPS   PASS
  int8           16384      5.398              1629.50 TOPS     PASS
  fp8_e4m3       16384      5.302              1659.11 TFLOPS   PASS

GPU 1: NVIDIA H200 NVL
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       7.881                58.86 TFLOPS   PASS
  fp32           12288      78.554               47.24 TFLOPS   PASS
  tf32           12288      8.827               420.41 TFLOPS   PASS
  bf16           16384      10.409              845.06 TFLOPS   PASS
  fp16           16384      10.413              844.71 TFLOPS   PASS
  int8           16384      5.443              1616.03 TOPS     PASS
  fp8_e4m3       16384      5.366              1639.38 TFLOPS   PASS

GPU 2: NVIDIA H200 NVL
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       7.877                58.89 TFLOPS   PASS
  fp32           12288      78.579               47.22 TFLOPS   PASS
  tf32           12288      8.731               425.00 TFLOPS   PASS
  bf16           16384      10.321              852.21 TFLOPS   PASS
  fp16           16384      10.330              851.49 TFLOPS   PASS
  int8           16384      5.406              1627.11 TOPS     PASS
  fp8_e4m3       16384      5.355              1642.55 TFLOPS   PASS

GPU 3: NVIDIA H200 NVL
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       7.865                58.98 TFLOPS   PASS
  fp32           12288      78.492               47.28 TFLOPS   PASS
  tf32           12288      8.802               421.60 TFLOPS   PASS
  bf16           16384      10.417              844.38 TFLOPS   PASS
  fp16           16384      10.418              844.29 TFLOPS   PASS
  int8           16384      5.443              1615.98 TOPS     PASS
  fp8_e4m3       16384      5.350              1644.22 TFLOPS   PASS

[concurrent]
GPU 0: NVIDIA H200 NVL
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       7.898                58.73 TFLOPS   PASS
  fp32           12288      78.583               47.22 TFLOPS   PASS
  tf32           12288      8.739               424.64 TFLOPS   PASS
  bf16           16384      10.308              853.29 TFLOPS   PASS
  fp16           16384      10.329              851.57 TFLOPS   PASS
  int8           16384      5.398              1629.41 TOPS     PASS
  fp8_e4m3       16384      5.297              1660.52 TFLOPS   PASS

GPU 1: NVIDIA H200 NVL
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       7.871                58.94 TFLOPS   PASS
  fp32           12288      78.533               47.25 TFLOPS   PASS
  tf32           12288      8.815               420.95 TFLOPS   PASS
  bf16           16384      10.410              844.98 TFLOPS   PASS
  fp16           16384      10.405              845.34 TFLOPS   PASS
  int8           16384      5.444              1615.70 TOPS     PASS
  fp8_e4m3       16384      5.376              1636.16 TFLOPS   PASS

GPU 2: NVIDIA H200 NVL
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       7.875                58.90 TFLOPS   PASS
  fp32           12288      78.587               47.22 TFLOPS   PASS
  tf32           12288      8.722               425.44 TFLOPS   PASS
  bf16           16384      10.315              852.75 TFLOPS   PASS
  fp16           16384      10.332              851.38 TFLOPS   PASS
  int8           16384      5.397              1629.76 TOPS     PASS
  fp8_e4m3       16384      5.296              1660.83 TFLOPS   PASS

GPU 3: NVIDIA H200 NVL
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       7.896                58.75 TFLOPS   PASS
  fp32           12288      78.618               47.20 TFLOPS   PASS
  tf32           12288      8.720               425.55 TFLOPS   PASS
  bf16           16384      10.322              852.18 TFLOPS   PASS
  fp16           16384      10.304              853.68 TFLOPS   PASS
  int8           16384      5.444              1615.88 TOPS     PASS
  fp8_e4m3       16384      5.303              1658.73 TFLOPS   PASS

  Concurrent aggregate:
    fp64               235.31 TFLOPS
    fp32               188.90 TFLOPS
    tf32              1696.58 TFLOPS
    bf16              3403.19 TFLOPS
    fp16              3401.96 TFLOPS
    int8              6490.75 TOPS
    fp8_e4m3          6616.24 TFLOPS

[UNSUPPORTED / SKIPPED]
  isolated GPU 0 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  isolated GPU 0 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  isolated GPU 0 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 9.0
  isolated GPU 1 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  isolated GPU 1 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  isolated GPU 1 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 9.0
  isolated GPU 2 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  isolated GPU 2 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  isolated GPU 2 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 9.0
  isolated GPU 3 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  isolated GPU 3 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  isolated GPU 3 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 9.0
  concurrent GPU 0 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  concurrent GPU 0 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  concurrent GPU 0 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 9.0
  concurrent GPU 1 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  concurrent GPU 1 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  concurrent GPU 1 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 9.0
  concurrent GPU 2 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  concurrent GPU 2 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  concurrent GPU 2 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 9.0
  concurrent GPU 3 int4: UNSUPPORTED - cuBLASLt does not provide a dense INT4 GEMM kernel; INT4 Tensor Core is used via inference frameworks (CUTLASS/quantized paths), not standard dense GEMM APIs
  concurrent GPU 3 fp8_e5m2: UNSUPPORTED - No cuBLASLt algorithm for fp8_e5m2 (CUBLAS_STATUS_NOT_SUPPORTED); cuBLASLt did not provide a kernel for this precision/layout on this GPU architecture
  concurrent GPU 3 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 9.0

