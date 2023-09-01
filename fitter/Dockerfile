FROM gdna_pifu_base:latest
LABEL maintainer "InheeLee <ininin0516@gmail.com>"
LABEL title="mesh_smpl_fitter"
LABEL version="0.2"
LABEL description="docker build of gdna-pifu preprocess on torch1.11.0+cu116"



# install smpl_fitter_preprocess requirements
WORKDIR /home
RUN . ~/.bashrc &&  \ 
    source activate gdna && \
    conda install -c conda-forge embree=2.17.7 openexr-python pyembree trimesh[soft] scikit-image && \
    pip install pyexr

# install smpl_fitter requirements
RUN . ~/.bashrc && \
    source activate gdna && \
    pip install scipy chumpy configer configargparse PyYAML pillow torchgeometry

RUN . ~/.bashrc && \
    source activate gdna && \
    conda install ffmpeg && \
    conda update ffmpeg 

RUN apt-get install xvfb -y

# due to numpy version issue of torchgeometry
COPY conversion.py /opt/conda/envs/gdna/lib/python3.7/site-packages/torchgeometry/core/conversions.py

EXPOSE 80 22 7008
CMD ["/bin/bash"]