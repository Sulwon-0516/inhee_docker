FROM gdna_pifu_base:latest
LABEL maintainer "InheeLee <ininin0516@gmail.com>"
LABEL title="hpcwild"
LABEL version="0.1"
LABEL description="docker build of hpcwild on torch1.12.1+cu116"



# install MPT
WORKDIR /home
RUN . ~/.bashrc &&  \ 
    source activate gdna && \
    pip install scipy numba filterpy && \
    pip install git+https://github.com/mkocabas/yolov3-pytorch.git && \ 
    pip install git+https://github.com/mkocabas/multi-person-tracker.git && \
    pip install pims av

# install detectron2 and donwload checkpoints
WORKDIR /home
RUN . ~/.bashrc && \
    source activate gdna && \
    git clone https://github.com/facebookresearch/detectron2 && \
    python -m pip install -e detectron2 && \
    cd detectron2/demo/ && \
    wget https://dl.fbaipublicfiles.com/detectron2/COCO-InstanceSegmentation/mask_rcnn_X_101_32x8d_FPN_3x/139653917/model_final_2d9806.pkl && \
    cd ../.. && \
    cd detectron2/projects/DensePose && \
    wget https://dl.fbaipublicfiles.com/densepose/densepose_rcnn_R_101_FPN_DL_s1x/165712116/model_final_844d15.pkl && \
    cd ../../..


RUN . ~/.bashrc && \
    source activate gdna && \
    conda install ffmpeg && \
    conda update ffmpeg  

EXPOSE 80 22 7008
CMD ["/bin/bash"]