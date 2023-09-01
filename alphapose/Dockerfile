FROM nvidia/cuda:11.3.1-devel-ubuntu20.04
LABEL maintainer "InheeLee <ininin0516@gmail.com>"
LABEL title="alphapose"
LABEL version="0.1"
LABEL description="docker build of alphapose based on torch1.12.1+cu113"
RUN which nvcc
RUN nvidia-smi


SHELL ["/bin/bash", "-c"]
ARG DEBIAN_FRONTEND=noninteractive
#0RUN rm /etc/apt/sources.list.d/cuda.list
#RUN rm /etc/apt/sources.list.d/nvidia-ml.list
RUN apt-key del 7fa2af80
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub
# The above 5 lines : handling issues of nvidia docker (2022)
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
    protobuf-compiler

ENV PATH /usr/local/cuda/bin:$PATH
ENV LD_LIBRARY_PATH /usr/local/cuda/lib64:$LD_LIBRARY_PATH

# Install MiniConda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    # /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc
ENV PATH /opt/conda/bin:$PATH

# For faster env resolving
RUN  . ~/.bashrc && conda init bash && \
    conda update conda && \
    conda install -n base conda-libmamba-solver && \
    conda config --set solver libmamba

# Install basic torch (11.3)
RUN . ~/.bashrc && \ 
    conda create -y -n alphapose python=3.9 && \
    source activate alphapose && \
    pip install torch==1.12.1+cu113 torchvision==0.13.1+cu113 torchaudio==0.12.1 --extra-index-url https://download.pytorch.org/whl/cu113

# Install 
WORKDIR /home/
RUN apt-get install -y libyaml-dev
RUN git clone https://github.com/MVIG-SJTU/AlphaPose.git


# You need to download modified HalpeCOCOAPI
# check following reference : https://github.com/HaoyiZhu/HalpeCOCOAPI/issues/1
# https://github.com/MVIG-SJTU/AlphaPose/issues/1002
# However, it seems like recent Alphapose do not depend on HalpeCOCOAPI anymore
WORKDIR /home
COPY HalpeCOCOAPI-master.zip /home/
RUN apt-get install -y unzip
RUN . ~/.bashrc && \ 
    source activate alphapose && \
    pip install cython setuptools && \
    pip install matplotlib && \
    unzip HalpeCOCOAPI-master.zip && \
    cd HalpeCOCOAPI-master/PythonAPI && \
    python setup.py build develop --user

RUN . ~/.bashrc && \ 
    source activate alphapose && \
    pip uninstall scipy && \
    pip install scipy && \
    pip install pycocotools && \
    cd AlphaPose && \
    python setup.py build develop

# 5. Install PyTorch3D (Optional, only for visualization)
RUN . ~/.bashrc && \ 
    source activate alphapose && \
    conda install -c fvcore -c iopath -c conda-forge fvcore iopath && \
    conda install -c bottler nvidiacub

RUN . ~/.bashrc && \
    source activate alphapose && \
    pip install chardet && \
    pip install --no-index --no-cache-dir pytorch3d -f https://dl.fbaipublicfiles.com/pytorch3d/packaging/wheels/py39_cu113_pyt1121/download.html
# COPY files & place in Docker 
# please refer to https://github.com/MVIG-SJTU/AlphaPose/blob/master/docs/INSTALL.md 
# you should prepare following files
# - osnet_ain_x1_0_msmt17_256x128_amsgrad_ep50_lr0.0015_coslr_b64_fb10_softmax_labsmth_flip_jitter.pth
# - multi_domain_fast50_dcn_combined_256x192.pth  
# - yolov3-spp.weights  
# - yolox_l.pth  
# - yolox_x.pth

COPY osnet_ain_x1_0_msmt17_256x128_amsgrad_ep50_lr0.0015_coslr_b64_fb10_softmax_labsmth_flip_jitter.pth /home/AlphaPose/trackers/weights/osnet_ain_x1_0_msmt17_256x128_amsgrad_ep50_lr0.0015_coslr_b64_fb10_softmax_labsmth_flip_jitter.pth
COPY multi_domain_fast50_dcn_combined_256x192.pth /home/AlphaPose/pretrained_models/multi_domain_fast50_dcn_combined_256x192.pth
COPY yolov3-spp.weights /home/AlphaPose/detector/yolo/data/yolov3-spp.weights
COPY yolox_l.pth /home/AlphaPose/detector/yolox/data/yolox_l.pth
COPY yolox_x.pth /home/AlphaPose/detector/yolox/data/yolox_x.pth

RUN . ~/.bashrc && \
    source activate alphapose && \
    conda install -y ffmpeg
