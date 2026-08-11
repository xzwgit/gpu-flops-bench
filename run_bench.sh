#!/usr/bin/env bash
# gpu-flops-bench 统一入口 - 自动检测 GPU 厂商并调用对应工具
# 用法: bash run_bench.sh [选项]  (选项透传给子工具)
#   --quick         快速模式
#   --device N      只测指定 GPU
#   --gpus all      测所有 GPU (默认)
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 检测 GPU 厂商
detect_gpu_vendor() {
    # 优先用 nvidia-smi / rocm-smi 检测
    if command -v nvidia-smi &>/dev/null && nvidia-smi -L &>/dev/null 2>&1; then
        echo "nvidia"
        return
    fi
    if command -v rocm-smi &>/dev/null && rocm-smi --showproductname &>/dev/null 2>&1; then
        echo "amd"
        return
    fi
    # 备选: lspci 检测
    if lspci 2>/dev/null | grep -qi "NVIDIA.*VGA\|NVIDIA.*3D\|NVIDIA.*Display"; then
        echo "nvidia"
        return
    fi
    if lspci 2>/dev/null | grep -qi "AMD.*Instinct\|Advanced Micro.*Display"; then
        echo "amd"
        return
    fi
    echo "unknown"
}

VENDOR=$(detect_gpu_vendor)

case "${VENDOR}" in
    nvidia)
        echo "=== 检测到 NVIDIA GPU ==="
        echo ""
        exec bash "${ROOT_DIR}/nvidia/run_gpu_flops.sh" "$@"
        ;;
    amd)
        echo "=== 检测到 AMD GPU ==="
        if [ -f "${ROOT_DIR}/amd/run_gpu_flops.sh" ]; then
            exec bash "${ROOT_DIR}/amd/run_gpu_flops.sh" "$@"
        else
            echo "❌ AMD 版本尚未实现"
            echo "   计划使用 hipBLASLt / rocBLAS，敬请期待"
            exit 1
        fi
        ;;
    *)
        echo "❌ 未检测到 NVIDIA 或 AMD GPU"
        echo ""
        echo "诊断信息:"
        echo "  nvidia-smi: $(command -v nvidia-smi || echo '不在 PATH')"
        echo "  rocm-smi:   $(command -v rocm-smi || echo '不在 PATH')"
        echo "  lspci GPU:"
        lspci 2>/dev/null | grep -iE "VGA|3D|Display|NVIDIA|AMD" | head -5 || echo "    (无)"
        echo ""
        echo "如果是 NVIDIA, 请确认 CUDA Toolkit 已安装 (nvcc 在 PATH 中)"
        echo "如果是 AMD, 请确认 ROCm 已安装 (hipcc 在 PATH 中)"
        exit 1
        ;;
esac
