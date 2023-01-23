FROM colmap:latest
LABEL maintainer "InheeLee <ininin0516@gmail.com>"
LABEL title="pifunerf preprocessing docker"
LABEL version="0.3"
LABEL description="docker build of pifu preprocess stage"

SHELL ["/bin/bash", "-c"]
# Intall pytorch
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH /opt/conda/bin:$PATH

# install additional packages
RUN echo "Installing apt packages..." \
	&& export DEBIAN_FRONTEND=noninteractive \
	&& apt -y update --no-install-recommends \
	&& apt -y install --no-install-recommends \
	git \
    vim \
    ffmpeg \
	tk-dev \
	libxi-dev \
	libc6-dev \
	libbz2-dev \
	libffi-dev \
	libomp-dev \
	libssl-dev \
	zlib1g-dev \
	libcgal-dev \
	libgdbm-dev \
	libglew-dev \
	python3-dev \
	python3-pip \
	qtbase5-dev \
	checkinstall \
	libglfw3-dev \
	libeigen3-dev \
	libgflags-dev \
	libxrandr-dev \
	libopenexr-dev \
	libsqlite3-dev \
	libxcursor-dev \
	build-essential \
	libcgal-qt5-dev \
	libxinerama-dev \
	libboost-all-dev \
	libfreeimage-dev \
	libncursesw5-dev \
	libatlas-base-dev \
	libqt5opengl5-dev \
	libgoogle-glog-dev \
	libsuitesparse-dev \
	python3-setuptools \
	libreadline-gplv2-dev \
	libatlas-base-dev \
	libqt5opengl5-dev \
	libgoogle-glog-dev \
	libglfw3-dev \
	libeigen3-dev \
	libgflags-dev \
	libxrandr-dev \
	libopenexr-dev \
	libsqlite3-dev \
	libxcursor-dev \
	build-essential \
	libcgal-qt5-dev \
	libxinerama-dev \
	libboost-all-dev \
	libfreeimage-dev \
	libncursesw5-dev \
	libatlas-base-dev \
	libqt5opengl5-dev \
	libgoogle-glog-dev \
	libsuitesparse-dev \
	python3-setuptools \
	libreadline-gplv2-dev \
    python3-dev \
    python3-pip \
    libopenexr-dev \
    libxi-dev \
    libglfw3-dev \
    libglew-dev \
    libomp-dev \
    libxinerama-dev \
    libxcursor-dev \
	&& apt autoremove -y \
	&& apt clean -y 



# Install MiniConda
# changed conda clean from -tipsy to -ay
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -ay && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN conda init bash && \
    conda update conda

WORKDIR /

RUN git clone https://github.com/apple/ml-neuman.git && \
    mv ml-neuman neuman

RUN cd /neuman/preprocess  && \
    git clone --recurse-submodules https://github.com/compphoto/BoostingMonocularDepth.git && \
    cd BoostingMonocularDepth && \
    git checkout ecedd0c0cf5e1807cdab1c5154351a97168e710d

RUN cd /neuman/preprocess  && \
    git clone --recurse-submodules https://github.com/jiangwei221/detectron2.git && \
    cd detectron2 && \
    git checkout 2048058b6790869e5add8832db2c90c556c24a3e

RUN  . ~/.bashrc && conda init bash

# depth estimation environment
RUN . ~/.bashrc && \
    conda create -n BMD python==3.8.8 && \
    source activate BMD && \
    conda install pytorch==1.10.0 torchvision==0.11.0 torchaudio==0.10.0 cudatoolkit=11.3 -c pytorch && \
    pip install matplotlib scipy scikit-image opencv-python ray commentjson pybind11

# detectron2 environment
RUN . ~/.bashrc && \
    source activate BMD && \
    cd /neuman/preprocess && \
    python -m pip install -e detectron2 && \
    pip install setuptools==59.5.0 && \
    pip list

# install cmake
WORKDIR /home 
RUN apt-get remove -y cmake && \ 
    cd cmake && \
    wget https://github.com/Kitware/CMake/releases/download/v3.24.2/cmake-3.24.2-linux-x86_64.sh && \
    chmod 777 ./cmake-3.24.2-linux-x86_64.sh && \
    ./cmake-3.24.2-linux-x86_64.sh --skip-license
ENV PATH /home/cmake/bin:$PATH

# instant-ngp
# install instant-ngp
WORKDIR /home
RUN git clone --recursive https://github.com/nvlabs/instant-ngp
WORKDIR /home/instant-ngp
RUN cmake . -B build
RUN cmake --build build --config RelWithDebInfo -j 4


CMD ["/bin/bash"]