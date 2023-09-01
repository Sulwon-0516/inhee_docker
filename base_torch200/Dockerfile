FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04
LABEL maintainer "InheeLee <ininin0516@gmail.com>"
LABEL title="torch200_cu118_base"
LABEL version="0.1"
LABEL description="docker build of nerfstudio based on torch2.0+cu118"
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

ENV PATH /usr/local/cuda-11.8/bin:$PATH
ENV LD_LIBRARY_PATH /usr/local/cuda-11.8/lib64:$LD_LIBRARY_PATH
ENV CUDA_HOME /usr/local/cuda-11.8

# Install MiniConda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    # /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc
ENV PATH /opt/conda/bin:$PATH

RUN  . ~/.bashrc && conda init bash && \
    conda update conda && \
    conda install -n base conda-libmamba-solver && \
    conda config --set solver libmamba

# Install basic torch (11.8)
RUN . ~/.bashrc && \ 
    conda create -n base_env python=3.10.11 -y && \
    source activate base_env && \
    conda install pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia -c conda-forge -y
    # pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
    


# # Install cmake (3.26 latest)
# WORKDIR /home 
# RUN apt-get remove -y cmake && \ 
#     mkdir cmake && cd cmake && \
#     wget https://github.com/Kitware/CMake/releases/download/v3.26.4/cmake-3.26.4-linux-x86_64.sh && \
#     chmod 777 ./cmake-3.26.4-linux-x86_64.sh && \
#     ./cmake-3.26.4-linux-x86_64.sh --skip-license
# ENV PATH /home/cmake/bin:$PATH


# # install some useful packages
# RUN . ~/.bashrc && \
#     source activate base_env && \
#     pip install --upgrade pip && pip install scikit-image matplotlib imageio plotly lack usort flake8 flake8-bugbear flake8-comprehensions && \
#     pip install matplotlib opencv-python-headless tqdm scikit-image PyOpenGL


EXPOSE 80 22 7008
CMD ["/bin/bash"]