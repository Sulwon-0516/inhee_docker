FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu18.04
LABEL maintainer "InheeLee <ininin0516@gmail.com>"
LABEL title="ihoi test"
LABEL version="0.1"
LABEL description="docker build of ihoi based on torch1.8.1+cu110"
RUN which nvcc

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

ENV PATH /usr/local/cuda-11.6/bin:$PATH
ENV LD_LIBRARY_PATH /usr/local/cuda-11.6/lib64:$LD_LIBRARY_PATH

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



# Install basic torch (1.8.2+11.1)
RUN . ~/.bashrc && \ 
    conda create -n ihoi python=3.8 -y && \
    source activate ihoi && \
    pip install torch==1.8.0+cu111 torchvision==0.9.0+cu111 torchaudio==0.8.0 -f https://download.pytorch.org/whl/torch_stable.html
    # conda install pytorch torchvision torchaudio cudatoolkit=11.1 -c pytorch-lts -c nvidia -y


# Install cmake
WORKDIR /home 
RUN apt-get remove -y cmake && \ 
    mkdir cmake && cd cmake && \
    wget https://github.com/Kitware/CMake/releases/download/v3.24.2/cmake-3.24.2-linux-x86_64.sh && \
    chmod 777 ./cmake-3.24.2-linux-x86_64.sh && \
    ./cmake-3.24.2-linux-x86_64.sh --skip-license
ENV PATH /home/cmake/bin:$PATH

# install torch3d
RUN . ~/.bashrc && \ 
    source activate ihoi && \
    conda install -c fvcore -c iopath -c conda-forge fvcore iopath && \
    conda install -c bottler nvidiacub

# RUN source ~/.bashrc && apt-get install libnvidia-gl
RUN . ~/.bashrc && \ 
    source activate ihoi && \
    pip install "git+https://github.com/facebookresearch/pytorch3d.git@v0.6.2"

# install ihoi
WORKDIR /home 
RUN . ~/.bashrc && \ 
    source activate ihoi && \
    git clone https://github.com/Sulwon-0516/ihoi.git && \
    cd ihoi && \
    pip install -r docs/requirements.txt


WORKDIR /home/ihoi
RUN . ~/.bashrc && \
    source activate ihoi && \
    sh ./scripts/one_click.sh

# Check whether ALL env are installed properly or NOT.
RUN . ~/.bashrc && \ 
    source activate ihoi && \
    conda list && \
    pip list

# # check whether it can install envs propely
# WORKDIR /home 
# RUN git clone https://github.com/ddshan/hand_object_detector && cd hand_object_detector/lib
# RUN . ~/.bashrc && \ 
#     source activate ihoi && \
#     cd hand_object_detector/lib && \
#     python setup.py build develop

