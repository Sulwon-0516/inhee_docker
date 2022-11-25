FROM torch3d:0.2.10
LABEL maintainer "InheeLee <ininin0516@gmail.com>"
LABEL title="Banmo Docker"
LABEL version="0.4"
LABEL description="test docker build of banmo based on torch1.10.0+cu113+pytorch3d"
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

RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y wget vim git gcc curl build-essential x11-apps
RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y llvm-6.0 ffmpeg libsm6 libxext6 libxrender1 libfontconfig1 libopenexr-dev x11-apps freeglut3-dev 

WORKDIR /home
RUN git clone --recursive https://github.com/Sulwon-0516/banmo.git
WORKDIR /home/banmo
COPY ./requirements.txt ./
RUN pip --no-cache-dir install -r ./requirements.txt 
WORKDIR /home/banmo
RUN pip install -e third_party/kmeans_pytorch \
    && python -m pip install detectron2 -f \
        https://dl.fbaipublicfiles.com/detectron2/wheels/cu113/torch1.10/index.html


EXPOSE 80 22 
CMD ["/bin/bash"]