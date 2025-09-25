#!/bin/bash

apt-get update && apt-get install -y locales && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    locale-gen en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/*

apt-get update && apt-get install -y \
      build-essential \
      ffmpeg \
      git \
      libglu1-mesa \
      python3 \
      sudo \
      unzip \
      vim \
      wget \
      && \
    apt-get update && apt-get install -y \
      doxygen \
      graphviz \
      texinfo \
      lcov \
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
      libvtk9-dev \
  && rm -rf /var/lib/apt/lists/*
