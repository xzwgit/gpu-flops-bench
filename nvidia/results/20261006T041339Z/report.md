Dense GPU GEMM Benchmark
Generated: 2026-10-06T04:21:12.228+00:00
Driver: 580.105.08
CUDA compiler: Cuda compilation tools, release 13.0, V13.0.88
Dense only: no 2:4 sparsity or sparse GEMM APIs

[isolated]
GPU 0: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       371.185               1.25 TFLOPS   PASS
  fp32           8192       19.227               57.19 TFLOPS   PASS
  tf32           12288      41.475               89.47 TFLOPS   PASS
  bf16           4096       0.772               178.03 TFLOPS   PASS
  fp16           4096       0.786               174.76 TFLOPS   PASS
  int8           16384      13.086              672.19 TOPS     PASS
  fp8_e4m3       16384      25.020              351.56 TFLOPS   PASS
  int4           0          0.000              1433.80 TOPS     OK
  bf16_mma       0          0.000               180.61 TFLOPS   OK
  fp8_e4m3_mma   0          0.000               360.03 TFLOPS   OK
  int8_mma       0          0.000               718.53 TFLOPS   OK

GPU 1: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       376.587               1.23 TFLOPS   PASS
  fp32           8192       19.351               56.82 TFLOPS   PASS
  tf32           12288      41.904               88.56 TFLOPS   PASS
  bf16           4096       0.783               175.45 TFLOPS   PASS
  fp16           4096       0.785               174.98 TFLOPS   PASS
  int8           16384      13.228              664.96 TOPS     PASS
  fp8_e4m3       16384      25.308              347.56 TFLOPS   PASS
  int4           0          0.000              1418.60 TOPS     OK
  bf16_mma       0          0.000               178.16 TFLOPS   OK
  fp8_e4m3_mma   0          0.000               355.92 TFLOPS   OK
  int8_mma       0          0.000               710.62 TFLOPS   OK

GPU 2: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       377.460               1.23 TFLOPS   PASS
  fp32           8192       19.356               56.81 TFLOPS   PASS
  tf32           12288      41.822               88.73 TFLOPS   PASS
  bf16           4096       0.782               175.68 TFLOPS   PASS
  fp16           8192       6.353               173.07 TFLOPS   PASS
  int8           16384      13.227              665.01 TOPS     PASS
  fp8_e4m3       16384      25.362              346.82 TFLOPS   PASS
  int4           0          0.000              1415.74 TOPS     OK
  bf16_mma       0          0.000               178.14 TFLOPS   OK
  fp8_e4m3_mma   0          0.000               355.90 TFLOPS   OK
  int8_mma       0          0.000               709.94 TFLOPS   OK

GPU 3: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       377.830               1.23 TFLOPS   PASS
  fp32           8192       19.474               56.46 TFLOPS   PASS
  tf32           12288      42.223               87.89 TFLOPS   PASS
  bf16           4096       0.790               174.08 TFLOPS   PASS
  fp16           4096       0.790               174.08 TFLOPS   PASS
  int8           16384      13.306              661.07 TOPS     PASS
  fp8_e4m3       16384      25.495              345.02 TFLOPS   PASS
  int4           0          0.000              1405.90 TOPS     OK
  bf16_mma       0          0.000               176.93 TFLOPS   OK
  fp8_e4m3_mma   0          0.000               353.45 TFLOPS   OK
  int8_mma       0          0.000               705.04 TFLOPS   OK

GPU 4: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           2048       13.871                1.24 TFLOPS   PASS
  fp32           8192       19.402               56.67 TFLOPS   PASS
  tf32           12288      41.717               88.95 TFLOPS   PASS
  bf16           4096       0.779               176.37 TFLOPS   PASS
  fp16           4096       0.780               176.17 TFLOPS   PASS
  int8           16384      13.226              665.06 TOPS     PASS
  fp8_e4m3       16384      25.256              348.28 TFLOPS   PASS
  int4           0          0.000              1422.32 TOPS     OK
  bf16_mma       0          0.000               179.20 TFLOPS   OK
  fp8_e4m3_mma   0          0.000               357.51 TFLOPS   OK
  int8_mma       0          0.000               712.77 TFLOPS   OK

GPU 5: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       377.773               1.23 TFLOPS   PASS
  fp32           8192       19.495               56.40 TFLOPS   PASS
  tf32           12288      42.055               88.24 TFLOPS   PASS
  bf16           4096       0.787               174.58 TFLOPS   PASS
  fp16           4096       0.786               174.76 TFLOPS   PASS
  int8           16384      13.290              661.88 TOPS     PASS
  fp8_e4m3       16384      25.425              345.96 TFLOPS   PASS
  int4           0          0.000              1413.41 TOPS     OK
  bf16_mma       0          0.000               177.91 TFLOPS   OK
  fp8_e4m3_mma   0          0.000               354.90 TFLOPS   OK
  int8_mma       0          0.000               708.38 TFLOPS   OK

GPU 6: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           4096       110.934               1.24 TFLOPS   PASS
  fp32           8192       19.104               57.55 TFLOPS   PASS
  tf32           12288      41.104               90.28 TFLOPS   PASS
  bf16           4096       0.769               178.73 TFLOPS   PASS
  fp16           4096       0.768               178.97 TFLOPS   PASS
  int8           16384      13.071              672.93 TOPS     PASS
  fp8_e4m3       16384      24.958              352.44 TFLOPS   PASS
  int4           0          0.000              1446.95 TOPS     OK
  bf16_mma       0          0.000               181.98 TFLOPS   OK
  fp8_e4m3_mma   0          0.000               363.60 TFLOPS   OK
  int8_mma       0          0.000               725.87 TFLOPS   OK

GPU 7: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       396.337               1.17 TFLOPS   PASS
  fp32           8192       20.010               54.95 TFLOPS   PASS
  tf32           12288      44.196               83.96 TFLOPS   PASS
  bf16           4096       0.825               166.52 TFLOPS   PASS
  fp16           8192       6.576               167.20 TFLOPS   PASS
  int8           16384      13.690              642.53 TOPS     PASS
  fp8_e4m3       8192       3.308               332.34 TFLOPS   PASS
  int4           0          0.000              1344.60 TOPS     OK
  bf16_mma       0          0.000               168.87 TFLOPS   OK
  fp8_e4m3_mma   0          0.000               337.40 TFLOPS   OK
  int8_mma       0          0.000               674.33 TFLOPS   OK

[concurrent]
GPU 0: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       372.364               1.25 TFLOPS   PASS
  fp32           8192       19.229               57.18 TFLOPS   PASS
  tf32           12288      41.475               89.47 TFLOPS   PASS
  bf16           4096       0.775               177.30 TFLOPS   PASS
  fp16           4096       0.774               177.54 TFLOPS   PASS
  int8           16384      13.157              668.53 TOPS     PASS
  fp8_e4m3       16384      25.028              351.45 TFLOPS   PASS
  int4           0          0.000              1433.72 TOPS     OK
  bf16_mma       0          0.000               180.18 TFLOPS   OK
  fp8_e4m3_mma   0          0.000               360.01 TFLOPS   OK
  int8_mma       0          0.000               718.81 TFLOPS   OK

GPU 1: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       376.585               1.23 TFLOPS   PASS
  fp32           8192       19.350               56.82 TFLOPS   PASS
  tf32           12288      41.907               88.55 TFLOPS   PASS
  bf16           4096       0.783               175.46 TFLOPS   PASS
  fp16           4096       0.782               175.68 TFLOPS   PASS
  int8           16384      13.164              668.22 TOPS     PASS
  fp8_e4m3       16384      25.301              347.66 TFLOPS   PASS
  int4           0          0.000              1418.85 TOPS     OK
  bf16_mma       0          0.000               178.15 TFLOPS   OK
  fp8_e4m3_mma   0          0.000               355.92 TFLOPS   OK
  int8_mma       0          0.000               710.62 TFLOPS   OK

GPU 2: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       377.430               1.23 TFLOPS   PASS
  fp32           8192       19.355               56.81 TFLOPS   PASS
  tf32           12288      42.023               88.31 TFLOPS   PASS
  bf16           4096       0.785               174.99 TFLOPS   PASS
  fp16           4096       0.785               175.00 TFLOPS   PASS
  int8           16384      13.224              665.18 TOPS     PASS
  fp8_e4m3       16384      25.339              347.14 TFLOPS   PASS
  int4           0          0.000              1415.60 TOPS     OK
  bf16_mma       0          0.000               178.14 TFLOPS   OK
  fp8_e4m3_mma   0          0.000               355.93 TFLOPS   OK
  int8_mma       0          0.000               710.17 TFLOPS   OK

GPU 3: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       378.668               1.22 TFLOPS   PASS
  fp32           8192       19.476               56.45 TFLOPS   PASS
  tf32           12288      42.225               87.88 TFLOPS   PASS
  bf16           4096       0.788               174.31 TFLOPS   PASS
  fp16           4096       0.789               174.12 TFLOPS   PASS
  int8           16384      13.301              661.32 TOPS     PASS
  fp8_e4m3       16384      25.476              345.27 TFLOPS   PASS
  int4           0          0.000              1407.64 TOPS     OK
  bf16_mma       0          0.000               176.93 TFLOPS   OK
  fp8_e4m3_mma   0          0.000               353.47 TFLOPS   OK
  int8_mma       0          0.000               705.09 TFLOPS   OK

GPU 4: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           4096       111.030               1.24 TFLOPS   PASS
  fp32           8192       19.398               56.68 TFLOPS   PASS
  tf32           12288      41.803               88.77 TFLOPS   PASS
  bf16           4096       0.781               175.92 TFLOPS   PASS
  fp16           4096       0.790               174.08 TFLOPS   PASS
  int8           16384      13.225              665.11 TOPS     PASS
  fp8_e4m3       16384      25.259              348.24 TFLOPS   PASS
  int4           0          0.000              1422.32 TOPS     OK
  bf16_mma       0          0.000               178.92 TFLOPS   OK
  fp8_e4m3_mma   0          0.000               357.45 TFLOPS   OK
  int8_mma       0          0.000               712.89 TFLOPS   OK

GPU 5: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       377.654               1.23 TFLOPS   PASS
  fp32           8192       19.485               56.43 TFLOPS   PASS
  tf32           12288      42.082               88.18 TFLOPS   PASS
  bf16           4096       0.791               173.65 TFLOPS   PASS
  fp16           4096       0.788               174.46 TFLOPS   PASS
  int8           16384      13.306              661.07 TOPS     PASS
  fp8_e4m3       16384      25.517              344.71 TFLOPS   PASS
  int4           0          0.000              1413.35 TOPS     OK
  bf16_mma       0          0.000               177.63 TFLOPS   OK
  fp8_e4m3_mma   0          0.000               354.67 TFLOPS   OK
  int8_mma       0          0.000               708.42 TFLOPS   OK

GPU 6: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       369.925               1.25 TFLOPS   PASS
  fp32           8192       19.105               57.55 TFLOPS   PASS
  tf32           12288      41.165               90.15 TFLOPS   PASS
  bf16           4096       0.769               178.72 TFLOPS   PASS
  fp16           4096       0.769               178.67 TFLOPS   PASS
  int8           16384      13.076              672.67 TOPS     PASS
  fp8_e4m3       16384      24.897              353.29 TFLOPS   PASS
  int4           0          0.000              1445.12 TOPS     OK
  bf16_mma       0          0.000               181.54 TFLOPS   OK
  fp8_e4m3_mma   0          0.000               362.74 TFLOPS   OK
  int8_mma       0          0.000               724.08 TFLOPS   OK

GPU 7: NVIDIA GeForce RTX 4090
  Precision      M=N=K      Median(ms)      Throughput       Validation
  fp64           6144       397.178               1.17 TFLOPS   PASS
  fp32           8192       20.012               54.94 TFLOPS   PASS
  tf32           12288      44.283               83.80 TFLOPS   PASS
  bf16           4096       0.827               166.18 TFLOPS   PASS
  fp16           8192       6.613               166.26 TFLOPS   PASS
  int8           16384      13.694              642.33 TOPS     PASS
  fp8_e4m3       8192       3.316               331.61 TFLOPS   PASS
  int4           0          0.000              1342.96 TOPS     OK
  bf16_mma       0          0.000               168.88 TFLOPS   OK
  fp8_e4m3_mma   0          0.000               337.42 TFLOPS   OK
  int8_mma       0          0.000               673.56 TFLOPS   OK

  Concurrent aggregate:
    fp64                 9.82 TFLOPS
    fp32               452.87 TFLOPS
    tf32               705.11 TFLOPS
    bf16              1396.53 TFLOPS
    fp16              1395.81 TFLOPS
    int8              5304.42 TOPS
    fp8_e4m3          2769.36 TFLOPS
    int4             11299.56 TOPS
    bf16_mma          1420.38 TFLOPS
    fp8_e4m3_mma      2837.61 TFLOPS
    int8_mma          5663.65 TFLOPS

[UNSUPPORTED / SKIPPED]
  isolated GPU 0 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  isolated GPU 0 fp4_e2m1: UNSUPPORTED - 
  isolated GPU 1 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  isolated GPU 1 fp4_e2m1: UNSUPPORTED - 
  isolated GPU 2 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  isolated GPU 2 fp4_e2m1: UNSUPPORTED - 
  isolated GPU 3 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  isolated GPU 3 fp4_e2m1: UNSUPPORTED - 
  isolated GPU 4 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  isolated GPU 4 fp4_e2m1: UNSUPPORTED - 
  isolated GPU 5 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  isolated GPU 5 fp4_e2m1: UNSUPPORTED - 
  isolated GPU 6 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  isolated GPU 6 fp4_e2m1: UNSUPPORTED - 
  isolated GPU 7 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  isolated GPU 7 fp4_e2m1: UNSUPPORTED - 
  concurrent GPU 0 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  concurrent GPU 0 fp4_e2m1: UNSUPPORTED - 
  concurrent GPU 1 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  concurrent GPU 1 fp4_e2m1: UNSUPPORTED - 
  concurrent GPU 2 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  concurrent GPU 2 fp4_e2m1: UNSUPPORTED - 
  concurrent GPU 3 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  concurrent GPU 3 fp4_e2m1: UNSUPPORTED - 
  concurrent GPU 4 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  concurrent GPU 4 fp4_e2m1: UNSUPPORTED - 
  concurrent GPU 5 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  concurrent GPU 5 fp4_e2m1: UNSUPPORTED - 
  concurrent GPU 6 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  concurrent GPU 6 fp4_e2m1: UNSUPPORTED - 
  concurrent GPU 7 nvfp4: UNSUPPORTED - Requires compute capability 10.0 or newer (Blackwell); device is 8.9
  concurrent GPU 7 fp4_e2m1: UNSUPPORTED - 

