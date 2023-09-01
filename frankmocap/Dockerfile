# FROM nvidia/cuda:11.6.2-cudnn8-devel-ubuntu20.04
FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-devel
LABEL maintainer "Hyunsoo Cha <729steven@gmail.com>"
LABEL title="Docker for FrankMocap"
LABEL version="0.1"
LABEL description="Docker build of Frankmocap based on torch1.10.0+cu11.3"

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

## Basic Packages
RUN apt-key del 7fa2af80
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub
# The above 5 lines : handling issues of nvidia docker (2022)
RUN sed -i 's/archive.ubuntu.com/ftp.daumkakao.com/g' /etc/apt/sources.list

# Add the Nvidia CUDA repository to the list of package sources
RUN echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC

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
RUN apt-get -y update && \ 
    apt-get install -y git nano zsh tzdata vim openssh-server sudo ufw curl
RUN apt-get install -y language-pack-en && sudo update-locale
RUN apt-get install -y libglu1-mesa libxi-dev libxmu-dev libglu1-mesa-dev freeglut3-dev libosmesa6-dev
RUN apt install -y xvfb && \
    apt-get install -y software-properties-common && \
    add-apt-repository universe && \
    apt-get install -y pymol
## zsh
SHELL ["/bin/zsh", "-c"]
RUN chsh -s `which zsh`

## oh-my-zsh
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN apt-get -y install fonts-powerline

## zsh-autosuggestions, zsh-syntax-highlighting을 플러그인에 추가하는 코드
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

## powerlevel10k
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
RUN wget -O /root/.p10k.zsh https://www.dropbox.com/s/7i95f3o6sisyqof/.p10k.zsh

RUN perl -pi -w -e 's/plugins=.*/plugins=(git ssh-agent zsh-autosuggestions zsh-syntax-highlighting)/g;' ~/.zshrc
# Set powerlevel10k as the default theme
RUN sed -i 's/ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' /root/.zshrc

# Set up the powerlevel10k theme
RUN echo 'source /root/.p10k.zsh' >> /root/.zshrc && \
    echo 'POWERLEVEL10K_DISABLE_CONFIGURATION=true' >> /root/.zshrc

## Install cmake
WORKDIR /root
RUN apt-get remove -y cmake && \ 
    mkdir cmake && cd cmake && \
    wget https://github.com/Kitware/CMake/releases/download/v3.24.2/cmake-3.24.2-linux-x86_64.sh && \
    chmod 777 ./cmake-3.24.2-linux-x86_64.sh && \
    ./cmake-3.24.2-linux-x86_64.sh --skip-license
ENV PATH /home/cmake/bin:$PATH

# # Install MiniConda
# RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
#     /bin/bash ~/miniconda.sh -b -p /opt/conda && \
#     rm ~/miniconda.sh && \
#     ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
#     echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.zshrc && \
#     echo "conda activate base" >> ~/.zshrc
# ENV PATH /opt/conda/bin:$PATH

## Anaconda3
RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.zshrc && \
    echo "conda activate base" >> ~/.zshrc
ENV PATH /opt/conda/bin:$PATH

RUN  . ~/.zshrc && conda init zsh && \
    conda update conda

RUN conda install -y ffmpeg
RUN python -m ensurepip --default-pip
RUN pip install --upgrade pip
ENV PIP_ROOT_USER_ACTION=ignore

# WORKDIR /root
ENV FORCE_CUDA 1
ENV TORCH_CUDA_ARCH_LIST="8.6+PTX"
# Install basic torch (11.6)
# RUN . ~/.zshrc && conda install pytorch==1.12.1 torchvision torchaudio cudatoolkit=11.6 -c pytorch -c conda-forge -y 
# RUN conda install -y pytorch==1.10.1 torchvision==0.11.2 torchaudio==0.10.1 cudatoolkit=11.3 -c pytorch -c conda-forge

# detectron2 installation
WORKDIR /root/GitHub
RUN git clone --recurse-submodules https://github.com/jiangwei221/detectron2.git && \
    cd detectron2 && \
    git checkout 2048058b6790869e5add8832db2c90c556c24a3e
RUN . ~/.zshrc && \
    cd /root/GitHub && \
    python -m pip install -e detectron2 && \
    pip install setuptools==59.5.0 && \
    pip list

# pytorch3d installation
# WORKDIR /root/GitHub
# RUN conda install -c fvcore -c iopath -c conda-forge fvcore iopath
# RUN conda install -c bottler nvidiacub
# RUN conda install jupyter
# RUN pip install scikit-image matplotlib imageio plotly opencv-python black usort flake8 flake8-bugbear flake8-comprehensions
# RUN conda install pytorch3d -c pytorch3d

## Install PyTorch3D
WORKDIR /root/GitHub/
RUN pip install ninja && \
    pip install "git+https://github.com/facebookresearch/pytorch3d.git"

RUN pip install numpy face_alignment natsort pandas seaborn
RUN pip install pip torchgeometry gdown opencv-python PyOpenGL PyOpenGL_accelerate pycocotools pafy youtube-dl scipy pillow easydict cython cffi msgpack pyyaml tensorboardX tqdm jinja2 smplx scikit-learn opendr chumpy

# WORKDIR /root/Archive
# RUN git clone https://github.com/HyunsooCha/frankmocap.git
# WORKDIR /root/Archive/frankmocap
# RUN sh scripts/install_frankmocap.sh

## ntfy
RUN python3 -m pip install git+https://github.com/dschep/ntfy.git@master --upgrade
RUN mkdir -p ~/.config/ntfy

RUN echo "function gitupdate() { \
    git pull; \
    echo '[INFO] pulling complete!'; \
    git add .; \
    echo '[INFO] adding complete!'; \
    if [ -z \"\$1\" ]; \
    then \
        today=\`date +%m-%d-%Y\`; \
        time=\`date +%H:%M:%S\`; \
        git commit -m \"update \$time \$today\"; \
    else \
        git commit -m \"\$1\"; \
    fi; \
    echo '[INFO] commiting complete!'; \
    git push origin main; \
    echo '[INFO] pushing complete!'; \
}; \
alias githard='git reset --hard HEAD && git pull'; \
alias gitsoft='git reset --soft HEAD^ '; \
alias gitcache='git rm -r --cached .'; \
alias ca='conda activate'; \
alias czsh='code ~/.zshrc'; \
alias szsh='source ~/.zshrc'; \
alias ta='tmux attach -t'; \
alias tl='tmux ls'; \
alias tn='tmux new -s'; \
function ffi2v() { \
    ffmpeg -i \$1 -c:v libx264 -profile:v high -pix_fmt yuv420p \$2; \
}; \
function ffv2i() { \
    ffmpeg -i \$1 -qscale:v 2 \$2; \
}; \
function ffglob() { \
    ffmpeg -framerate \$1 -pattern_type glob -i \$2 -c:v libx264 -profile:v high -pix_fmt yuv420p \$3; \
}; \
alias wn='watch -d -n 0.5 nvidia-smi'; \
alias gpu0='CUDA_VISIBLE_DEVICES=0'; \
alias gpu1='CUDA_VISIBLE_DEVICES=1'; \
alias gpu2='CUDA_VISIBLE_DEVICES=2'; \
alias gpu3='CUDA_VISIBLE_DEVICES=3'; \
alias gpu4='CUDA_VISIBLE_DEVICES=4'; \
alias gpu5='CUDA_VISIBLE_DEVICES=5'; \
alias gpu6='CUDA_VISIBLE_DEVICES=6'; \
alias gpu7='CUDA_VISIBLE_DEVICES=7'; \
alias ram='watch -d -n 0.5 free -h'; \
alias caphere='sudo du -h --max-depth=1'; \
alias python='ntfy done python'" >> ~/.zshrc


## set up the working directory
WORKDIR /root/GitHub/frankmocap

EXPOSE 22

CMD ["zsh"]