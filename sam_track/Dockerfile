FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-devel
LABEL maintainer "InheeLee <ininin0516@gmail.com>"
LABEL title="SAM track"
LABEL version="0.1"
LABEL description="docker build of SAM track on torch2.0.x+cu117"

SHELL ["/bin/bash", "-c"]
ARG DEBIAN_FRONTEND=noninteractive

RUN sed -i 's/archive.ubuntu.com/ftp.daumkakao.com/g' /etc/apt/sources.list
RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y wget vim git gcc curl build-essential
RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y ffmpeg libsm6 libxext6 libopenexr-dev x11-apps freeglut3-dev cmake libboost-program-options-dev \
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
    libsuitesparse-dev \
    libprotobuf-dev \
    protobuf-compiler \
    unzip

ENV PATH /usr/local/cuda/bin:$PATH
ENV LD_LIBRARY_PATH /usr/local/cuda/lib64:$LD_LIBRARY_PATH
ENV CUDA_HOME /usr/local/cuda

# install SAM-track
WORKDIR /home
RUN git clone https://github.com/z-x-yang/Segment-and-Track-Anything.git

WORKDIR /home/Segment-and-Track-Anything
RUN bash script/install.sh && \
    pip install gradio

RUN pip install gdown
# donwload checkpoints
WORKDIR /home/Segment-and-Track-Anything
RUN mkdir ckpt && \
    bash script/download_ckpt.sh

RUN apt-get install unzip zip
RUN pip install -U imageio==2.25.1

CMD ["/bin/bash"]