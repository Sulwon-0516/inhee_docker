#!/bin/bash
# Here I made a file to run docker file with mounting folders easily.
DEV_DIR="/home/inhee"
HDD_DIR="/home/disk1/inhee"
RES_DIR="/home/inhee/result"

KAOLIN="kaolin:0.5"
KAOLIN_WISP="kaolin-wisp:0.2"
KAOLIN_WISP_SCREEN="kaolin-wisp-screen:latest"
COLMAP="colmap:0.1"
INSTANT_NGP="instant-ngp:latest"
BANMO="banmo:latest"
TORCH3D="torch3d:latest"
DENSECORRES="densecorres:latest"
STYLEGAN2ADA="sg2ada:latest"
DETECTRON2="detectron2:latest"
NEUMAN_PREPROCESS="neuman_preprocess:latest"
PIFUHD="pifuhd:latest"
NERFSTUDIO="nerfstudio:modified"
NERFACC="nerfacc:latest"
NGP_PL="ngp_pl:latest"
TORCH_NGP="torch_ngp:latest"
FRANKMOCAP="frankmocap:latest"
PIFUNERF_PREPROCESS="pifunerf_preprocess:latest"
HYPERNERF_JAX="hypernerf_jax:latest"


DISPLAY=":1"
SHM_SIZE="128gb"
PORT="-p 12000:7010"

#GPUS="all"
#GPUS='"device=5,6,7"'
GPUS='"device=4"'

if [ $# -eq 0 ]
    then 
        echo "argument : docker env to run"  
elif [ $# -eq 1 ]   
    then
        echo "1 argumnet : we use default container name"
fi



if [ "$1" == "kaolin" ]
    then 
        if [ $# -eq 1 ]
            then
                echo "kaolin"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -it \
                    --gpus=$GPUS \
                    $KAOLIN
        elif [ $# -eq 2 ]
            then
                echo "kaolin"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -it \
                    --gpus=$GPUS \
                    --name=$2 \
                    $KAOLIN
        fi

elif [ "$1" == "kaolin-screen" ]
    then
        if [ $# -eq 1 ]
            then
                echo "kaolin-screen"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    $KAOLIN
        elif [ $# -eq 2 ]
            then
                echo "kaolin-screen"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --name=$2 \
                    $KAOLIN
        fi 
        
    
elif [ "$1" == "kaolin-wisp" ]
    then
        if [ $# -eq 1 ]
            then
                echo "kaolin-wisp"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -it \
                    --gpus=$GPUS \
                    $KAOLIN_WISP
        elif [ $# -eq 2 ]
            then
                echo "kaolin-wisp"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -it \
                    --gpus=$GPUS \
                    --name=$2 \
                    $KAOLIN_WISP
        fi

elif [ "$1" == "kaolin-wisp-screen" ]
    then
        if [ $# -eq 1 ]
            then
                echo "kaolin-wisp-screen"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    $KAOLIN_WISP_SCREEN
        elif [ $# -eq 2 ]
            then
                echo "kaolin-wisp-screen"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --name=$2 \
                    $KAOLIN_WISP_SCREEN
        fi


elif [ "$1" == "colmap" ]
    then
        if [ $# -eq 1 ]
            then
                echo "colmap"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    $COLMAP
        elif [ $# -eq 2 ]
            then
                echo "colmap"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --name=$2 \
                    $COLMAP
        fi

elif [ "$1" == "instant-ngp" ]
    then
        if [ $# -eq 1 ]
            then
                echo "instant-ngp"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    $INSTANT_NGP
        elif [ $# -eq 2 ]
            then
                echo "instant-ngp"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --name=$2 \
                    $INSTANT_NGP
        fi

elif [ "$1" == "banmo" ]
    then
        if [ $# -eq 1 ]
            then
                echo "banmo"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    $BANMO
        elif [ $# -eq 2 ]
            then
                echo "banmo"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --name=$2 \
                    $BANMO
        fi

elif [ "$1" == "torch3d" ]
    then
        if [ $# -eq 1 ]
            then
                echo "torch3d"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    $TORCH3D
        elif [ $# -eq 2 ]
            then
                echo "torch3d"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --name=$2 \
                    $TORCH3D
        fi
        
elif [ "$1" == "densecorres" ]
    then
        if [ $# -eq 1 ]
            then
                echo "densecorres"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    $DENSECORRES
        elif [ $# -eq 2 ]
            then
                echo "densecorres"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --name=$2 \
                    $DENSECORRES
        fi

elif [ "$1" == "stylegan2ada" ]
    then
        if [ $# -eq 1 ]
            then
                echo "denstylegan2adasecorres"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    $STYLEGAN2ADA \
                    /bin/bash
        elif [ $# -eq 2 ]
            then
                echo "stylegan2ada"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --name=$2 \
                    $STYLEGAN2ADA \
                    /bin/bash
        fi


elif [ "$1" == "detectron2" ]
    then
        if [ $# -eq 1 ]
            then
                echo "detectron2"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    $DETECTRON2
        elif [ $# -eq 2 ]
            then
                echo "detectron2"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --name=$2 \
                    $DETECTRON2
        fi


elif [ "$1" == "neuman_preprocess" ]
    then
        if [ $# -eq 1 ]
            then
                echo "neuman_preprocess"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    $NEUMAN_PREPROCESS
        elif [ $# -eq 2 ]
            then
                echo "neuman_preprocess"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --name=$2 \
                    $NEUMAN_PREPROCESS
        fi


elif [ "$1" == "pifuhd" ]
    then
        if [ $# -eq 1 ]
            then
                echo "pifuhd"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --net=host \
                    $PIFUHD
        elif [ $# -eq 2 ]
            then
                echo "pifuhd"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --net=host \
                    --name=$2 \
                    $PIFUHD
        fi



elif [ "$1" == "nerfstudio" ]
    then
        if [ $# -eq 1 ]
            then
                echo "nerfstudio"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --net=host \
                    $PORT \
                    $NERFSTUDIO
        elif [ $# -eq 2 ]
            then
                echo "nerfstudio"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --net=host \
                    --name=$2 \
                    $PORT \
                    $NERFSTUDIO
        fi

elif [ "$1" == "nerfacc" ]
    then
        if [ $# -eq 1 ]
            then
                echo "nerfacc"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --net=host \
                    $NERFACC
        elif [ $# -eq 2 ]
            then
                echo "nerfacc"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --net=host \
                    --name=$2 \
                    $NERFACC
        fi


elif [ "$1" == "ngp_pl" ]
    then
        if [ $# -eq 1 ]
            then
                echo "ngp_pl"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --net=host \
                    $NGP_PL
        elif [ $# -eq 2 ]
            then
                echo "ngp_pl"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --net=host \
                    --name=$2 \
                    $NGP_PL
        fi  

elif [ "$1" == "torch_ngp" ]
    then
        if [ $# -eq 1 ]
            then
                echo "torch_ngp"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --net=host \
                    $TORCH_NGP
        elif [ $# -eq 2 ]
            then
                echo "torch_ngp"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --net=host \
                    --name=$2 \
                    $TORCH_NGP
        fi  



elif [ "$1" == "tcnn7" ]
    then
        if [ $# -eq 1 ]
            then
                echo "tcnn cu117"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --net=host \
                    tcnn:0.1.7
        elif [ $# -eq 2 ]
            then
                echo "tcnn cu117"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --net=host \
                    --name=$2 \
                    tcnn:0.1.7
        fi  


elif [ "$1" == "tcnn6" ]
    then
        if [ $# -eq 1 ]
            then
                echo "tcnn cu116"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --net=host \
                    tcnn:0.1.6
        elif [ $# -eq 2 ]
            then
                echo "tcnn cu116"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --net=host \
                    --name=$2 \
                    tcnn:0.1.6
        fi


elif [ "$1" == "frankmocap" ]
    then
        if [ $# -eq 1 ]
            then
                echo "frankmocap"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --net=host \
                    $PORT \
                    $FRANKMOCAP
        elif [ $# -eq 2 ]
            then
                echo "frankmocap"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=$GPUS \
                    --net=host \
                    --name=$2 \
                    $PORT \
                    $FRANKMOCAP
        fi


elif [ "$1" == "pifunerf_preprocess" ]
    then
        if [ $# -eq 1 ]
            then
                echo "pifunerf_preprocess"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=${GPUS} \
                    $PIFUNERF_PREPROCESS
        elif [ $# -eq 2 ]
            then
                echo "pifunerf_preprocess"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=${GPUS} \
                    --name=$2 \
                    $PIFUNERF_PREPROCESS
        fi

elif [ "$1" == "hypernerf_jax" ]
    then
        if [ $# -eq 1 ]
            then
                echo "hypernerf_jax"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=${GPUS} \
                    $HYPERNERF_JAX
        elif [ $# -eq 2 ]
            then
                echo "hypernerf_jax"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -e DISPLAY=unix$DISPLAY \
                    -it \
                    --gpus=${GPUS} \
                    --name=$2 \
                    $HYPERNERF_JAX
        fi

else
    echo "wrong argument"
fi
