#!/bin/bash

# Check if an example name was provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 <example_name> [planner|world]"
    echo "Examples:"
    echo "  $0 heijn_push          # Lists available scripts"
    echo "  $0 heijn_push planner  # Runs the planner"
    echo "  $0 heijn_push world    # Runs the world simulation"
    exit 1
fi

EXAMPLE_DIR="examples/$1"

# Check if the example directory exists
if [ ! -d "$EXAMPLE_DIR" ]; then
    echo "Error: Example directory '$EXAMPLE_DIR' not found."
    echo "Available examples:"
    ls -1 examples/
    exit 1
fi

# If no second argument, list available scripts
if [ $# -lt 2 ]; then
    echo "Available scripts in $EXAMPLE_DIR:"
    ls -1 "$EXAMPLE_DIR"/*.py | xargs -n1 basename
    exit 0
fi

SCRIPT="$2.py"

# Check if the script exists
if [ ! -f "$EXAMPLE_DIR/$SCRIPT" ]; then
    echo "Error: Script '$SCRIPT' not found in '$EXAMPLE_DIR'."
    echo "Available scripts:"
    ls -1 "$EXAMPLE_DIR"/*.py | xargs -n1 basename
    exit 1
fi

# Run the script with the environment set up
./setup_env.sh python3 "$EXAMPLE_DIR/$SCRIPT"
