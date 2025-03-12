# Overview
This is an implementation of a Model Predictive Path Integral (MPPI) controller which uses IsaacGym as a dynamic model for the rollouts. We provide several examples of what tasks you can solve with it: 

<p align="center">
<img src="docs/source/overview_gif.gif"/>
</p>

You can extend the repository with your robots and tasks since it is designed to be modular and reusable. 

### How to cite this work
If you found this repository useful, please consider citing the associated paper below:

```bash
@misc{pezzato2023samplingbased,
      title={Sampling-based Model Predictive Control Leveraging Parallelizable Physics Simulations}, 
      author={Corrado Pezzato and Chadi Salmi and Max Spahn and Elia Trevisan and Javier Alonso-Mora and Carlos Hernandez Corbato},
      year={2023},
      eprint={2307.09105},
      archivePrefix={arXiv},
      primaryClass={cs.RO}
}
```

# Installation

*NOTE: To use the GPU pipeline (default) you need an NVIDIA graphics card. If you do not have one, you can use the CPU pipeline, with fewer samples.*

This project requires the source code of IsaacGym inside the folder
`thirdparty`. Download it from https://developer.nvidia.com/isaac-gym, extract it, and place
it in `mppi-isaac/thirdparty`. Then you can proceed with the installation described below. 

## Virtual environment (advised)
You can install the necessary dependencies using [poetry](https://python-poetry.org/docs/) virtual environment. After installing poetry, move into `mppi-isaac` and run
```bash
poetry install --with dev
```
Bear in mind that the installation might take several minutes the first time. But it's worth it.

Access the virtual environment using
```bash
poetry shell
```

### Virtual environment - Pycharm
If you are using Pycharm (professional), first add a new Python interpreter via 'Add New Interpreter', 'Add local interpreter" and 
create a virtual environment within the mppi-isaac folder called 'venv'. Then install the necessary dependencies using [poetry](https://python-poetry.org/docs/) in the virtual environment.
```bash
poetry install --with dev
```

### **Test the installation**
Test that everything is properly set up, use pytest
```bash
cd examples
poetry run pytest
```
## System-level installation
Alternatively, you can also install at the system level using pip, even though we advise using the virtual environment:
```bash
pip install .
```

## Running Examples

Each example requires running two scripts in separate terminals:

1. First terminal: Run the planner script
2. Second terminal: Run the world script

### Using the Helper Scripts

We provide helper scripts to simplify running the examples:

```bash
# First terminal: Run the planner for an example
./run_example.sh heijn_push planner

# Second terminal: Run the world simulation for the same example
./run_example.sh heijn_push world
```

Available examples include:
- `heijn_push`: A robot pushing a block to a goal position
- `panda`: A robotic arm reaching for a target
- `boxer_push`: A robot pushing a block to a goal position
- And many more in the examples directory

To list all available examples:
```bash
ls -1 examples/
```

## Troubleshooting

### Rendering Issues
If you have an Nvidia card and after running the simulation you get a black screen, you might need to force the use of the GPU card through the following environment variables:

```bash
export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json
export LD_LIBRARY_PATH=/path/to/your/conda/env/lib:$LD_LIBRARY_PATH
```

Replace `/path/to/your/conda/env/lib` with the path to your conda/mamba environment's lib folder. Run these commands before launching any script.

Note: The `setup_env.sh` script included in this repository automatically sets these environment variables for you.

### Client-Server Timeout Issues
If you encounter timeout errors like `zerorpc.exceptions.LostRemote: Lost remote after 10s heartbeat` when running the client-server examples, you may need to increase the zerorpc timeout settings. Here's how to modify the scripts:

1. In the world.py (server) script, increase the timeout and heartbeat when creating the zerorpc client:
   ```python
   planner = zerorpc.Client(timeout=60, heartbeat=30)  # Increased from default 10s
   ```

2. In the planner.py (client) script, increase the heartbeat when creating the zerorpc server:
   ```python
   planner = zerorpc.Server(MPPIisaacPlanner(cfg, objective, prior=None), heartbeat=30)
   ```

These modifications help with systems that have slower rendering performance or when the GPU is under heavy load.

# Running the examples
Access the virtual environment if installed with poetry (with `poetry shell`). You can run two types of examples, either the ones using IsaacGym or the ones using Pybullet. In the `examples` folder, you find all the scripts. 

## IsaacGym examples
To run the examples with IsaacGym (`panda`, `heijn_push`, `boxer_push`, `albert` and more), you need two terminals because it is required to run a "server" and a "client" script. In the first one run the server:
```bash 
python3 world.py
```
In the second one the client:
```bash 
python3 planner.py
```

## Pybullet examples
In some older branches, you can run one of the example scripts which use Pybullet, for instance for the panda robot:
```bash
python3 panda_robot_with_obstacles.py
```
