#!/bin/bash
set -e
DEV_DIR="/home/inhee/VCL"
RES_DIR="/mnt/hdd"
HDD2_DIR="/mnt/hdd2"
HDD3_DIR="/mnt/hdd3"

# image names
IMAVATAR="imavatar:latest"
PREPROCESS="gdna_pifu_preprocess:latest"
FITTER="gdna_pifu_fitter:latest"
OPENPOSE="openpose:latest"
BASE="gdna_pifu_base:latest"
GDNA="gdna:latest"
FM_HYUNSOO="frankmocap_hyunsoo:latest"
IHOI="ihoi:latest"
SAM_TRACK="sam_track:latest"
INSIGHTFACE="insightface:latest"
DRAMA_PREPROCESS="drama_preprocess:latest"
_2K2K="2k2k:latest"
INSTANT_AVATAR="instant_avatar:latest"
FACE_PREPROCESS="face_preprocess_230727:latest"
ALPHAPOSE="alphapose:latest"

# common arguments
DISPLAY=":1"
SHM_SIZE="64gb"

# optional global arguments
ADD_ARGS="-it"
# ADD_ARGS="-it"
COMMANDS="/bin/bash"

# bash file argument settings
if [ $# -eq 0 ]
    then 
        echo "argument : docker env to run"  
elif [ $# -eq 1 ]   
    then
        echo "1 argumnet : we use default container name"
fi

# get image name to launch
if [ "$1" == "imavatar" ]
    then
        IMG_NAME=$IMAVATAR
elif [ "$1" == "frankmocap" ]
    then
        IMG_NAME=$FM_HYUNSOO
elif [ "$1" == "preprocess" ]
    then
        IMG_NAME=$PREPROCESS
elif [ "$1" == "fitter" ]
    then
        IMG_NAME=$FITTER
elif [ "$1" == "openpose" ]
    then
        IMG_NAME=$OPENPOSE
elif [ "$1" == "base" ]
    then
        IMG_NAME=$BASE
elif [ "$1" == "gdna" ]
    then
        IMG_NAME=$GDNA
elif [ "$1" == "ihoi" ]
    then
        IMG_NAME=$IHOI
elif [ "$1" == "sam_track" ]
    then
        IMG_NAME=$SAM_TRACK
elif [ "$1" == "insightface" ]
    then
        IMG_NAME=$INSIGHTFACE
elif [ "$1" == "drama_preprocess" ]
    then
        IMG_NAME=$DRAMA_PREPROCESS
elif [ "$1" == "2k2k" ]
    then
        IMG_NAME=$_2K2K
elif [ "$1" == "instant_avatar" ]
    then
        IMG_NAME=$INSTANT_AVATAR
elif [ "$1" == "face_preprocess_230727" ]
    then
        IMG_NAME=$FACE_PREPROCESS
elif [ "$1" == "alphapose" ]
    then
        IMG_NAME=$ALPHAPOSE
fi


# Launch 
if [ $# -eq 1 ]
    then
        echo "[run] "$1" image"
        docker run \
            -v $DEV_DIR:$DEV_DIR \
            -v $RES_DIR:$RES_DIR \
            -v $HDD2_DIR:$HDD2_DIR \
            -v $HDD3_DIR:$HDD3_DIR \
            --shm-size=$SHM_SIZE \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -e DISPLAY=unix$DISPLAY \
            $ADD_ARGS \
            --gpus=all \
            --net=host \
            $IMG_NAME \
            $COMMANDS

elif [ $# -eq 2 ]
    then
        echo "[run] "$1" image"
        docker run \
            -v $DEV_DIR:$DEV_DIR \
            -v $RES_DIR:$RES_DIR \
            -v $HDD2_DIR:$HDD2_DIR \
            -v $HDD3_DIR:$HDD3_DIR \
            --shm-size=$SHM_SIZE \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -e DISPLAY=unix$DISPLAY \
            $ADD_ARGS \
            --gpus=all \
            --net=host \
            --name=$2 \
            $IMG_NAME \
            $COMMANDS
fi



