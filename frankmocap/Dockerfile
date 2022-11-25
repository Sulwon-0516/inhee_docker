FROM nvidia/cuda:11.6.2-cudnn8-devel-ubuntu20.04
LABEL maintainer "InheeLee <ininin0516@gmail.com>"
LABEL title="frankmocap Docker"
LABEL version="0.0.1"
LABEL description="docker build of frankmocap based on torch1.11.0+cu116"
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
RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y \
    ffmpeg \
    libsm6 \
    libxext6 \
    libopenexr-dev \
    x11-apps \
    freeglut3-dev \
    cmake \ 
    libboost-program-options-dev \
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
    libglu1-mesa \
    libxi-dev \
    libxmu-dev \
    libglu1-mesa-dev \
    freeglut3-dev \
    libosmesa6-dev

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

WORKDIR /home
# Install basic torch (11.6)
RUN . ~/.bashrc && \ 
    conda create -n frankmocap python=3.9 -y && \
    source activate frankmocap && \
    conda install pytorch==1.12.1 torchvision torchaudio cudatoolkit=11.6 -c pytorch -c conda-forge -y 

# install other required libraries of frankmocap
RUN . ~/.bashrc && \
    source activate frankmocap && \
    pip install pip gdown opencv-python PyOpenGL PyOpenGL_accelerate pycocotools pafy youtube-dl scipy pillow \
        easydict cython cffi msgpack pyyaml tensorboardX tqdm jinja2 smplx sklearn opendr chumpy torchgeometry scikit-learn

# detectron2 installation
WORKDIR /home
RUN git clone --recurse-submodules https://github.com/jiangwei221/detectron2.git && \
    cd detectron2 && \
    git checkout 2048058b6790869e5add8832db2c90c556c24a3e
RUN . ~/.bashrc && \
    source activate frankmocap && \
    cd /home && \
    python -m pip install -e detectron2 && \
    pip install setuptools==59.5.0 && \
    pip list

# torch3d installation
WORKDIR /home
RUN . ~/.bashrc && \
    source activate frankmocap && \
    conda install -c fvcore -c iopath -c conda-forge fvcore iopath
RUN . ~/.bashrc && \
    source activate frankmocap && \
    conda install -c bottler nvidiacub
RUN . ~/.bashrc && \
    source activate frankmocap && \
    conda install jupyter
RUN . ~/.bashrc && \
    source activate frankmocap && \
    pip install scikit-image matplotlib imageio plotly opencv-python black usort flake8 flake8-bugbear flake8-comprehensions
RUN . ~/.bashrc && \
    source activate frankmocap && \
    conda install pytorch3d -c pytorch3d

# dowmload frankmocap & place a few thrid party modules
WORKDIR /home
RUN . ~/.bashrc && \
    source activate frankmocap && \
    git clone https://github.com/Sulwon-0516/frankmocap.git && \
    cd frankmocap && \
    sh scripts/install_frankmocap.sh

# update & install some packages to avoid error
RUN . ~/.bashrc && \
    source activate frankmocap && \
    conda update ffmpeg -y


# copy SMPL / SMPL-X from inhee's repo
COPY SMPLX_NEUTRAL.pkl /home/frankmocap/extra_data/smpl/SMPLX_NEUTRAL.pkl
COPY basicmodel_neutral_lbs_10_207_0_v1.1.0.pkl /home/frankmocap/extra_data/smpl/basicModel_neutral_lbs_10_207_0_v1.0.0.pkl

EXPOSE 80 22 
CMD ["/bin/bash"]