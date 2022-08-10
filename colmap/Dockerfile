FROM nvidia/cuda:11.3.1-devel-ubuntu20.04
LABEL maintainer "InheeLee <ininin0516@gmail.com>"
LABEL title="COLMAP Docker"
LABEL version="0.1"
LABEL description="test docker build of COLMAP based on cuda 11.3.1, Ubuntu20.04"
RUN which nvcc
RUN nvidia-smi

SHELL ["/bin/bash", "-c"]
#0RUN rm /etc/apt/sources.list.d/cuda.list
#RUN rm /etc/apt/sources.list.d/nvidia-ml.list
RUN apt-key del 7fa2af80
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub
# The above 5 lines : handling issues of nvidia docker (2022)
RUN which nvcc
RUN nvidia-smi
RUN sed -i 's/archive.ubuntu.com/ftp.daumkakao.com/g' /etc/apt/sources.list

ARG DEBIAN_FRONTEND=noninteractive
# Above line remove interative mode
RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y wget vim git gcc curl build-essential x11-apps
RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y cmake libboost-program-options-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-system-dev \
    libboost-test-dev \
    libeigen3-dev \
    libsuitesparse-dev \
    libfreeimage-dev \
    libmetis-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    libglew-dev \
    qtbase5-dev \
    libqt5opengl5-dev \
    libcgal-dev \
    libatlas-base-dev \
    libsuitesparse-dev

WORKDIR /home
RUN git clone --recursive https://ceres-solver.googlesource.com/ceres-solver
WORKDIR /home/ceres-solver
WORKDIR /home/ceres-solver/build
RUN cmake .. -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF && make -j && make install

WORKDIR /home
RUN git clone https://github.com/colmap/colmap.git
WORKDIR /home/colmap
RUN git checkout dev
WORKDIR /home/colmap/build
RUN cmake .. && make -j && make install
RUN colmap -h

EXPOSE 80 22 
CMD ["/bin/bash"]