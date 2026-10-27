#!/usr/bin/env bash
# run_quant_bench.sh — 量化推理 GEMM 基准入口 (Humming 引擎)
# 用法: bash run_quant_bench.sh [--device 0] [--shape-n 4096] [--shape-k 4096] ...
# 环境要求: python3 + PyTorch(建议 cu13x) + CUDA 工具链(nvcc)
# 依赖安装: pip install triton tqdm  (humming 已内置源码, 无需安装)
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"

# 找 python: 优先带 torch 的
PY=""
for c in "${PYTHON:-}" python3 /usr/bin/python3; do
    command -v "$c" >/dev/null 2>&1 || continue
    if "$c" -c "import torch" 2>/dev/null; then PY="$c"; break; fi
done
if [ -z "$PY" ]; then
    echo "错误: 未找到带 PyTorch 的 python (pip install torch --index-url https://download.pytorch.org/whl/cu130)" >&2
    exit 1
fi

# nvcc / CUDA_HOME
if [ -z "${CUDA_HOME:-}" ]; then
    for d in /usr/local/cuda-13* /usr/local/cuda; do
        [ -x "$d/bin/nvcc" ] && export CUDA_HOME="$d" && break
    done
fi
export PATH="$CUDA_HOME/bin:$PATH"

exec "$PY" "$HERE/quant_bench.py" "$@"
