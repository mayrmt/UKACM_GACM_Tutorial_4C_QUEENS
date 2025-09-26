#!/bin/bash

# Install cmake
# Call with
# ./install.sh /path/to/install/dir

# Exit the script at the first failure
set -e

INSTALL_DIR="$1"
# Number of procs for building (default 4)
NPROCS=${NPROCS=4}
VERSION="3.30.5"

wget --no-verbose https://cmake.org/files/v3.30/cmake-3.30.5-linux-aarch64.sh

chmod +x cmake-3.30.5-linux-aarch64.sh
./cmake-3.30.5-linux-aarch64.sh --prefix=${INSTALL_DIR} --skip-license
rm cmake-3.30.5-linux-aarch64.sh
