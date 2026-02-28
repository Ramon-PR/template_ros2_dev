#!/bin/bash
# Used to automatize the compilation of a python package
# Usage: ./compile_pkg.sh <package_name>
# Steps:
# 1. Get project directory 
# 2. Get ros2 ws directory
# 3. Get package directory
# 4. Copy auto_setup.py to package directory
# 5. cd to package directory
# 6. Run auto_setup.py (Updates setup.py with all the python files in the package)
# 7. Compile the package using colcon build

ws_name=${1:-new_ros2_ws}
pkg_name=${2:-pkg_ros2_opencv}

BASH_SCRIPT=$(realpath "$0")
SCRIPTS_DIR=$(dirname "$BASH_SCRIPT")

# 1. Get project directory
ROOT_DIR=$(dirname "$SCRIPTS_DIR")
echo "Root directory: $ROOT_DIR"

# 2. Get ros2 ws directory
ROS2_WS_DIR="$ROOT_DIR/$ws_name"
echo "ROS2 workspace directory: $ROS2_WS_DIR"

# 3. Get package directory
ROS2_PKG_DIR="$ROS2_WS_DIR/src/$pkg_name"
echo "ROS2 package directory: $ROS2_PKG_DIR"

# 4. Copy auto_setup.py to package directory
cp "$SCRIPTS_DIR/python_scripts/auto_setup.py" "$ROS2_PKG_DIR/auto_setup.py"

# 5. cd to package directory
cd "$ROS2_PKG_DIR"

# 6. Run auto_setup.py (Updates setup.py with all the python files in the package)
python3 auto_setup.py

# 7. Compile the package using colcon build
cd "$ROS2_WS_DIR"
colcon build --packages-select "$pkg_name" --symlink-install