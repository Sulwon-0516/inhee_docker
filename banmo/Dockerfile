FROM pytorch/pytorch:1.11.0-cuda11.3-cudnn8-devel
LABEL maintainer "InheeLee <ininin0516@gmail.com>"
LABEL title="Banmo Docker"
LABEL version="0.1"
LABEL description="test docker build of banmo based on torch1.11.0"
RUN which nvcc
RUN nvidia-smi

SHELL ["/bin/bash", "-ic"]
#0RUN rm /etc/apt/sources.list.d/cuda.list
#RUN rm /etc/apt/sources.list.d/nvidia-ml.list
RUN apt-key del 7fa2af80
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub
# The above 5 lines : handling issues of nvidia docker (2022)
RUN which nvcc
RUN nvidia-smi
RUN sed -i 's/archive.ubuntu.com/ftp.daumkakao.com/g' /etc/apt/sources.list
RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y wget vim git gcc curl build-essential
RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y ffmpeg libsm6 libxext6 libopenexr-dev x11-apps freeglut3-dev

WORKDIR /home
RUN git clone --recursive https://github.com/Sulwon-0516/banmo.git
WORKDIR /home/banmo
RUN conda env create -f misc/banmo-cu113.yml 
RUN source conda activate banmo-cu113 && pip install -e third_party/pytorch3d \
    && pip install -e third_party/kmeans_pytorch \
    && python -m pip install detectron2 -f \
        https://dl.fbaipublicfiles.com/detectron2/wheels/cu113/torch1.10/index.html


EXPOSE 80 22 
CMD ["/bin/bash"]