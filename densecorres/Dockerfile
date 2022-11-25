FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-devel
LABEL maintainer "InheeLee <ininin0516@gmail.com>"
LABEL title="densecorres Docker"
LABEL version="0.2"
LABEL description="docker build of densecorres based on torch1.10.0+cu113"
RUN which nvcc
RUN nvidia-smi

SHELL ["/bin/bash", "-c"]
#0RUN rm /etc/apt/sources.list.d/cuda.list
#RUN rm /etc/apt/sources.list.d/nvidia-ml.list
RUN apt-key del 7fa2af80
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub
# The above 5 lines : handling issues of nvidia docker (2022)
RUN sed -i 's/archive.ubuntu.com/ftp.daumkakao.com/g' /etc/apt/sources.list
RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y wget vim git gcc curl build-essential
RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y ffmpeg libsm6 libxext6 libopenexr-dev x11-apps freeglut3-dev

WORKDIR /home
RUN python -m pip install detectron2 -f https://dl.fbaipublicfiles.com/detectron2/wheels/cu113/torch1.10/index.html
RUN python -m pip install av opencv-python-headless scipy

EXPOSE 80 22 
CMD ["/bin/bash"]