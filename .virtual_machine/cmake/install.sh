#!/bin/bash
# This file is part of 4C multiphysics licensed under the
# GNU Lesser General Public License v3.0 or later.
#
# See the LICENSE.md file in the top-level for license information.
#
# SPDX-License-Identifier: LGPL-3.0-or-later

# Install cmake
# Call with
# ./install.sh /path/to/install/dir

# Exit the script at the first failure
set -e

INSTALL_DIR="$1"
# Number of procs for building (default 4)
NPROCS=${NPROCS=4}
VERSION="3.30.5"
CHECKSUM="83de8839f3fb0d9caf982a0435da3fa8c4fbe2c817dfec99def310dc7e6a8404"

wget --no-verbose https://github.com/Kitware/CMake/releases/download/v${VERSION}/cmake-${VERSION}-linux-x86_64.sh
# Verify checksum
if [ $CHECKSUM = `sha256sum cmake-${VERSION}-linux-x86_64.sh | awk '{print $1}'` ]
then

  echo "Checksum matches"
else
  sha256sum cmake-${VERSION}-linux-x86_64.sh | awk '{print $1}'
  echo $CHECKSUM
  echo "Checksum does not match"
  exit 1
fi

chmod +x cmake-${VERSION}-linux-x86_64.sh
./cmake-${VERSION}-linux-x86_64.sh --prefix=${INSTALL_DIR} --skip-license
rm cmake-${VERSION}-linux-x86_64.sh
