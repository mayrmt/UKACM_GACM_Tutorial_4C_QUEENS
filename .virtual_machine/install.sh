#!/bin/bash

sudo apt-get update
sudo apt-get install -y \
      build-essential \
      ffmpeg \
      git \
      libglu1-mesa \
      unzip \
      vim \
      wget \
      libblas-dev \
      libboost-all-dev \
      libcln-dev \
      libhdf5-dev \
      libhdf5-openmpi-dev \
      libnetcdf-dev \
      libfftw3-dev \
      lld \
      python3 \
      python3-venv \
      python-is-python3 \
      liblapack-dev \
      libopenmpi-dev \
      libparmetis-dev \
      libmetis-dev \
      libsuitesparse-dev \
      ninja-build \
      libyaml-dev \
      clang \
      clang-tidy \
      clang-tools \
      libomp-dev \
      libvtk9-dev

sudo apt autoremove

sudo rm -rf /var/lib/apt/lists/*

NPROC=8
INSTALL_DIR='/home/participant/opt/4C-dependencies'
mkdir -p ${INSTALL_DIR}

source cmake/install.sh ${INSTALL_DIR}
source qhull/install.sh ${INSTALL_DIR}
source suitesparse/install.sh ${INSTALL_DIR}
source superlu_dist/install.sh ${INSTALL_DIR}
source trilinos/install.sh ${INSTALL_DIR}
