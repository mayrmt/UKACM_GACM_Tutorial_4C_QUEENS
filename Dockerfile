# Get the docker image from 4C
FROM ghcr.io/4c-multiphysics/4c:latest

USER root

# Install wget to fetch Miniconda
RUN apt-get update && \
    apt-get install -y wget libgl1-mesa-dev xvfb rsync &&\
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Miniconda on x86 or ARM platforms
RUN arch=$(uname -m) && \
    if [ "$arch" = "x86_64" ]; then \
    MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"; \
    elif [ "$arch" = "aarch64" ]; then \
    MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh"; \
    else \
    echo "Unsupported architecture: $arch"; \
    exit 1; \
    fi && \
    wget $MINICONDA_URL -O miniconda.sh && \
    /bin/bash miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh && \
    echo "export PATH=/opt/conda/bin:$PATH" > /etc/profile.d/conda.sh


ENV PATH /opt/conda/bin:$PATH

RUN conda --version

RUN conda init bash
RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r


# Clone QUEENS
# Different to the main branch in terms of dependencies
RUN git clone -b ukacm_gacm_2025 https://github.com/gilrrei/queens.git

# Install QUEENS
RUN conda create -n queens python=3.11
RUN cd queens && conda run pip install -e .
RUN mkdir UKACM_GACM_Tutorials

COPY 4C/ UKACM_GACM_Tutorials/4C
COPY QUEENS/ UKACM_GACM_Tutorials/QUEENS
COPY 4C_QUEENS/ UKACM_GACM_Tutorials/4C_QUEENS
COPY additional_requirements.txt additional_requirements.txt

RUN conda run pip install -r additional_requirements.txt

ENV OMPI_ALLOW_RUN_AS_ROOT=1
ENV OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1
