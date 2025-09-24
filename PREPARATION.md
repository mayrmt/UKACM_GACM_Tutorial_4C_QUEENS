# Preparatory steps for the 4C and QUEENS workshop

This document describes the preparatory steps necessary to participate in the 4C and QUEENS workshop during the UKACM-GACM autumn school 2024.
It is recommended to go through these steps at least one day before the tutorial starts,
so that any issues can be resolved in time.

For the workshop it is not necessary to install 4C and QUEENS on your own computer,
as a virtual machine appliance is provided, which contains all necessary software.
However, if you prefer to use a docker container instead of the virtual machine,
you may do so, but no support will be provided on how to install and use docker.
Some information is given [below](#docker).

The VM applicance is a virtual Ubuntu 24.04 system with 4C and a few other software packages preinstalled. 

## Prerequisites

On the hardware side it is beneficial to have a powerful computer with at least 4 physical cores (better 8) and 16 GB RAM, 
and 50 GB free space on the hard disk.

The only software needed here is Oracle virtualBox (in the following denoted as VB). 
The VB version tested is 7.1.
If you don't have it already, please download VB from https://www.virtualbox.org/wiki/Downloads and install it on your computer.

## Installation

The virtual machine appliance is the file [`4C_linux.ova`](https://hereon-my.sharepoint.com/:f:/g/personal/ingo_scheider_hereon_de/Es_VRBHDVhJAua4KcDG5-n0BaeOgq5yWBU9k4IBmtPZ63A?e=KakAVC). 
Note that the size of the file is more than 12 Gb, so the download should be done with a solid and fast connection.

After receiving the repository locally, 
1. start VB, 
1. import the appliance into VB, 
1. adjust the setting to memory and number of cpus, which fits to your hardware environment, 
1. start the VM
1. Click on the username `participant`. When asked for credentials, type `4C.workshop` 

## Docker

If you prefer docker instead, you may get the docker container using the command

```
docker pull ghcr.io/4c-multiphysics/4c:main
```

When running the docker container, you should still download the repository with the tutorial material to your computer,
and mount it into the docker container, e.g., using 
```docker run -it -v /path/to/tutorial-material:/home/participant/tutorial-material ghcr.io/4c-multiphysics/4c:main /bin/bash```
where `/path/to/tutorial-material` is the path on your computer where you downloaded the tutorial material.

Additionally, you should have paraview on your computer.

## License

While for most of the software installed in the virtual machine, their own licenses exist, 
note that 4C is licensed by the GNU Lesser General Public License v3.0 or later.
