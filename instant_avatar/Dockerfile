FROM nvcr.io/nvidia/pytorch:22.08-py3


SHELL ["/bin/bash", "-c"]
ARG DEBIAN_FRONTEND=noninteractive
RUN sed -i 's/archive.ubuntu.com/ftp.daumkakao.com/g' /etc/apt/sources.list

RUN pip install aitviewer==1.9.0 && \
    # pip install torch==1.13.1+cu116 torchvision==0.14.1 --extra-index-url https://download.pytorch.org/whl/cu116 && \
    pip install fvcore iopath && \
    pip install git+https://github.com/NVlabs/tiny-cuda-nn/@v1.6#subdirectory=bindings/torch && \
    pip install pytorch-lightning==1.5.7

RUN pip install imageio && \
    pip install smplx==0.1.28 && \
    pip install hydra-core==1.1.2 && \
    pip install h5py ninja chumpy numpy==1.23.1 && \
    pip install lpips


