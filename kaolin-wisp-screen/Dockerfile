FROM kaolin:0.5
LABEL maintainer "InheeLee <ininin0516@gmail.com>"
LABEL title="Kaolin-wisp-screen Docker"
LABEL version="0.2"
LABEL description="test docker build of kaolin-wisp based on torch1.11.0 + kaolin 1.12.0. No display support now"
RUN which nvcc
RUN nvidia-smi

SHELL ["/bin/bash", "-c"]
#0RUN rm /etc/apt/sources.list.d/cuda.list
#RUN rm /etc/apt/sources.list.d/nvidia-ml.list

WORKDIR /home
RUN git clone --recursive https://github.com/NVIDIAGameWorks/kaolin-wisp.git
WORKDIR /home/kaolin-wisp
RUN pip install -r requirements.txt


# Install visualizer dependeices
ENV CUDA_HOME /usr/local/cuda-11.3
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute
RUN apt-get update && apt-get install -y \
    libglvnd0 \
    libgl1-mesa-dev \
    libgl1 \
    libglx0 \
    libegl1 \
    libxext6 \
    libx11-6 \
    glmark2

WORKDIR /home
RUN git clone --recursive https://github.com/inducer/pycuda
WORKDIR /home/pycuda
RUN python configure.py --cuda-root=$CUDA_HOME --cuda-enable-gl && python setup.py develop
WORKDIR /home/kaolin-wisp
RUN pip install -r requirements_app.txt

RUN python setup.py develop

EXPOSE 80 22 
CMD ["/bin/bash"]