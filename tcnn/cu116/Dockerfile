FROM nvidia/cuda:11.6.2-cudnn8-devel-ubuntu20.04
LABEL maintainer "InheeLee <ininin0516@gmail.com>"
LABEL title="tcnn Docker"
LABEL version="0.1.6"
LABEL description="docker build of tcnn based on cu116 (w/ torch 11.6)"
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

ENV PATH /usr/local/cuda-11.6/bin:$PATH
ENV LD_LIBRARY_PATH /usr/local/cuda-11.6/lib64:$LD_LIBRARY_PATH

# Install MiniConda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc
ENV PATH /opt/conda/bin:$PATH

RUN  . ~/.bashrc && conda init bash && \
    conda update conda

# Install basic torch (11.6)
RUN . ~/.bashrc && \ 
    conda create -n tcnn python=3.9 -y && \
    source activate tcnn && \
    conda install pytorch==1.12.0 torchvision==0.13.0 torchaudio==0.12.0 cudatoolkit=11.6 -c pytorch -c conda-forge -y


# Install cmake
WORKDIR /home 
RUN apt-get remove -y cmake && \ 
    mkdir cmake && cd cmake && \
    wget https://github.com/Kitware/CMake/releases/download/v3.24.2/cmake-3.24.2-linux-x86_64.sh && \
    chmod 777 ./cmake-3.24.2-linux-x86_64.sh && \
    ./cmake-3.24.2-linux-x86_64.sh --skip-license
ENV PATH /home/cmake/bin:$PATH


# Install tcnn
WORKDIR /home
RUN echo $PATH
RUN . ~/.bashrc && source activate tcnn && pip install --upgrade pip && pip install scikit-image matplotlib imageio plotly opencv-python black usort flake8 flake8-bugbear flake8-comprehensions
RUN git clone --recursive https://github.com/nvlabs/tiny-cuda-nn && \
    cd tiny-cuda-nn && mkdir build

WORKDIR /home/tiny-cuda-nn
RUN cmake . -B build
RUN cmake --build build --config RelWithDebInfo -j
# Test whether tcnn installed properly
RUN cd build && ./mlp_learning_an_image ../data/images/albert.jpg ../data/config_hash.json 10000

# install tcnn-python binding
RUN cd /home/tiny-cuda-nn/bindings/torch && source activate tcnn && \
    python setup.py install

# Test whether tcnn-python binding installed properly
RUN cd /home/tiny-cuda-nn && source activate tcnn && pip install commentjson && \
    python samples/mlp_learning_an_image_pytorch.py ./data/images/albert.jpg ./data/config_hash.json 10000


EXPOSE 80 22 7008
CMD ["/bin/bash"]