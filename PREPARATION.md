# Preparatory steps for the 4C and QUEENS workshop

This document describes the preparatory steps necessary to participate in the 4C and QUEENS workshop during the UKACM-GACM autumn school 2025.
It is recommended to go through these steps at least one day before the tutorial starts,
so that any issues can be resolved in time.

For the workshop, it is not necessary to install 4C and QUEENS on your own computer. Different software containers with the necessary software already pre-installed are provided (virtual machine appliance, docker container).

The choice between a virtual machine or docker containers is either based on personal preference or might be dictated by you hardware specifications.

- The **virtual machine** only works for `x86_64` architectures.
- Participants with **arm** architecture, e.g. Mac users with Apple Silicon, must resort to the docker container.

> We cannot provide support during the workshop on the installation of virtual machine frameworks or docker. Please test it in advance.

This document describes both scenarios:

- [Virtual machine](#virtual-machine)
- [Docker container](#docker-container)

## Virtual machine

### Prerequisites

This VM can be installed on any x86_64 architecture. 
The installation to computers with ARM processors appears to be problematic.

It is beneficial to have a powerful computer with at least 4 physical cores (better 8 or more) and 16 GB RAM, 
and 50 GB free space on the hard disk.

The only software needed here is Oracle virtualBox (in the following denoted as VB). 
The VB version tested is 7.1.
If you don't have it already, please download VB from https://www.virtualbox.org/wiki/Downloads and install it on your computer.

### Installation

The virtual machine appliance is the file [`4C_linux.ova`](https://hereon-my.sharepoint.com/:u:/g/personal/ingo_scheider_hereon_de/Efkhgd6WdvxJmUbfJl4vGCoBvmIm5NaVAXzInRCSCxVpNw?e=DGGnzF). 
Note that the size of the file is about 12 Gb, so the download should be done with a solid and fast connection.

After receiving the repository locally, 
1. start VB, 
1. import the appliance into VB, 
1. adjust the setting to memory and number of cpus, which fits to your hardware environment 
   (note that the VM should have at least 16 GB RAM and 4 CPUs assigned),
1. start the VM
1. You should not be asked for a username/password. 
   In case you are, click on the username `participant`. If asked for credentials, type `4C.workshop`
2. After the VM has started, please open a terminal window (you'll find the terminal icon on the left icon bar of the main window).
3. Download the repository with the tutorial material by typing the command
   ```
   git clone https://github.com/mayrmt/UKACM_GACM_Tutorial_4C_QUEENS.git
   ```


## Docker container

### Prerequesites

The following software must be installed on your machine:

- Docker to run 4C and QUEENS (Note: his might require root access)
- ParaView to inspect 4C simulation results
- A text editor or integated development environment (IDE) of your choice to modify input files and scripts

### Geeting the tutorial materials

The tutorial material is provided in a public [GitHub repository](https://github.com/mayrmt/UKACM_GACM_Tutorial_4C_QUEENS).

To clone the repository to your machine, open a terminal and navigate to a directory of your choice, where the data should be stored. Then clone the repository with one of these options:

- If you have `git`, a GitHub account and `ssh` credentials on GitHub:
   ```bash
   git clone git@github.com:mayrmt/UKACM_GACM_Tutorial_4C_QUEENS.git
   ```

- If you have `git`, but no GitHub account:
   ```bash
   git clone https://github.com/mayrmt/UKACM_GACM_Tutorial_4C_QUEENS.git
   ```

- If you do not have `git` on your machine: _Open the [GitHub repository](https://github.com/mayrmt/UKACM_GACM_Tutorial_4C_QUEENS) in your browser. Then click the green `<> Code` button and select "Download ZIP" from the menu._
   ![](fig/github_download_zip.png)
  _Unpack/unzip the directory using the method of your choice._

### Getting and running a docker container

To download and run the pre-compiled docker container for the 4C tutorial, follow the instructions for your operating system:

- **MacOS / Linux / Windows Subsystem for Linux:** Open a terminal and navigate into the top level directory of the tutorial repository. Then, start the docker container as follows:
   ```bash
   docker run -i -t -v `pwd`:/home/user/tutorial ghcr.io/4c-multiphysics/4c-minimal:latest /bin/bash
   ```
   When you execute this command for the first time, this will download the docker container from the internet. It will then start the container and open a `bash` shell. You will find yourself in the home director of the user `user` with two directories, `4C` (pre-installed 4C executable) and `tutorial` (tutorial files on your machine that you have cloned in the previous step).

- **Windows:** :warning: Georg, please fill in the details!