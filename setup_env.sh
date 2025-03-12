#!/bin/bash

# Set up environment variables for GPU rendering
export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json
export LD_LIBRARY_PATH=/home/munir/miniforge3/envs/mppi-isaac/lib:$LD_LIBRARY_PATH

# Activate the conda environment
# Note: source is used instead of conda/mamba activate because the script runs in a subshell
source $(conda info --base)/etc/profile.d/conda.sh
conda activate mppi-isaac

# Execute the command passed as arguments if any
if [ $# -gt 0 ]; then
    exec "$@"
else
    echo "Environment set up successfully. You can now run your commands."
    echo "For example:"
    echo "  cd examples/heijn_push && python3 planner.py"
    echo "  cd examples/heijn_push && python3 world.py"
    # Keep the shell open with the environment activated
    $SHELL
fi
