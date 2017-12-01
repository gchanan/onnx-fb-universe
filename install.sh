#!/bin/bash

set -ex

if [[ "$(uname)" == 'Darwin' ]]; then
    script_path=$(realpath -e "${BASH_SOURCE[0]}")
else
    script_path=$(readlink -e "${BASH_SOURCE[0]}")
fi
top_dir=$(dirname "$script_path")
REPOS_DIR="$top_dir/repos"
BUILD_DIR="$top_dir/build"
mkdir -p "$BUILD_DIR"

# Install caffe2
ccache -z
time pip install -b "$BUILD_DIR/caffe2" "file://$REPOS_DIR/caffe2#egg=caffe2"
ccache -s

# Install onnx
ccache -z
time pip install -b "$BUILD_DIR/onnx" "file://$REPOS_DIR/onnx#egg=onnx"
ccache -s

# Install onnx-caffe2
ccache -z
time pip install -b "$BUILD_DIR/onnx-caffe2" "file://$REPOS_DIR/onnx-caffe2#egg=onnx-caffe2"
ccache -s

# Install pytorch
pip install -r "$REPOS_DIR/pytorch/requirements.txt"
ccache -z
time pip install -b "$BUILD_DIR/pytorch" "file://$REPOS_DIR/pytorch#egg=torch"
ccache -s

# Install onnx-pytorch
ccache -z
time pip install -b "$BUILD_DIR/onnx-pytorch" "file://$REPOS_DIR/onnx-pytorch#egg=onnx-pytorch"
ccache -s