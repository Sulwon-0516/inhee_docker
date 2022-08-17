#!/bin/bash
# Here I made a file to run docker file with mounting folders easily.
DEV_DIR="/home/inhee/VCL/insect_recon"
HDD_DIR="/mnt/hdd"
RES_DIR="/home/inhee/VCL/results"

KAOLIN="kaolin:0.5"
KAOLIN_WISP="kaolin-wisp:0.2"
KAOLIN_WISP_SCREEN="kaolin-wisp-screen:latest"
COLMAP="colmap:0.1"
INSTANT_NGP="instant-ngp:latest"
BANMO="banmo:latest"
TORCH3D="torch3d:latest"
SHM_SIZE="32gb"


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
                    --gpus=all \
                    $KAOLIN
        elif [ $# -eq 2 ]
            then
                echo "kaolin"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -it \
                    --gpus=all \
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
                    --gpus=all \
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
                    --gpus=all \
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
                    --gpus=all \
                    $KAOLIN_WISP
        elif [ $# -eq 2 ]
            then
                echo "kaolin-wisp"
                docker run -v $DEV_DIR:$DEV_DIR \
                    -v $HDD_DIR:$HDD_DIR \
                    -v $RES_DIR:$RES_DIR \
                    --shm-size=$SHM_SIZE \
                    -it \
                    --gpus=all \
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
                    --gpus=all \
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
                    --gpus=all \
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
                    --gpus=all \
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
                    --gpus=all \
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
                    --gpus=all \
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
                    --gpus=all \
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
                    --gpus=all \
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
                    --gpus=all \
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
                    --gpus=all \
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
                    --gpus=all \
                    --name=$2 \
                    $TORCH3D
        fi

else
    echo "wrong argument"
fi