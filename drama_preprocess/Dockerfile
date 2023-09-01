FROM gdna_pifu_preprocess:latest
LABEL maintainer "InheeLee <ininin0516@gmail.com>"
LABEL title="drama_preprocess"
LABEL version="0.1"
LABEL description="docker build of drama preprocess on torch1.11.0+cu116"


# install PHALP
# It has installtation issues. (need to downgrade setuptools < 55 and install scikit-learn==0.22 first + update env)
WORKDIR /home
RUN . ~/.bashrc && \
    git clone https://github.com/brjathu/PHALP.git && \
    cd PHALP && \
    git checkout v1.1 && \
    conda create -n PHALP python=3.9.16

# This step will make error, but be continued
RUN . ~/.bashrc&& \
    source activate PHALP && \
    # conda install -y pytorch==1.13.1 torchvision==0.14.1 torchaudio==0.13.1 pytorch-cuda=11.6 -c pytorch -c nvidia && \
    conda install pytorch==1.12.1 torchvision==0.13.1 torchaudio==0.12.1 cudatoolkit=11.6 -c pytorch -c conda-forge && \
    python -c 'import torch;print(torch.cuda.is_available())'

RUN . ~/.bashrc&& \
    source activate PHALP && \
    conda env update -y --file env.yaml; exit 0



RUN apt-get install -y gfortran 

# Ad I had issue on installing scipy==1.9.1, instead, used scipy==1.10.1
WORKDIR /home
RUN . ~/.bashrc && \
    source activate PHALP && \
    cd PHALP && \
    pip install setuptools==54.0.0 && \
    pip install cython && \
    pip install scipy==1.10.1 && \
    pip install scikit-learn==0.22 && \
    conda env update --file env.yaml  && \
    pip install -e .

# install insight face
RUN . ~/.bashrc && \
    source activate PHALP && \
    pip install onnxruntime-gpu && \
    pip install InsightFace


RUN . ~/.bashrc && \
    source activate PHALP && \
    conda update -y ffmpeg

# install openpose (controlnet-aux)
WORKDIR /home
RUN git clone https://github.com/patrickvonplaten/controlnet_aux
WORKDIR /home/controlnet_aux
RUN . ~/.bashrc && \
    source activate PHALP && \
    pip install opencv-contrib-python mediapipe && \
    pip install -e .

# Check torch installed properly
RUN . ~/.bashrc && \
    source activate PHALP && \
    python -c 'import torch;print(torch.cuda.is_available())'

WORKDIR /home/inhee/VCL

