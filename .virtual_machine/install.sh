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

sudo rm -rf /var/lib/apt/lists/*

cmake/install.sh
qhull/install.sh
suitesparse/install.sh
superlu_dist/install.sh
trilinos/install.sh
