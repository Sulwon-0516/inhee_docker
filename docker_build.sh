if [ $# -eq 0 ]
    then 
        echo "argument : docker env to run"
        
fi

if [ "$1" == "base" ]
    then 
        echo "[build] base image"
        docker build ./base -t gdna_pifu_base:0.1 -t gdna_pifu_base:latest

elif [ "$1" == "preprocess" ]
    then 
        echo "[build] preprocess image"
        docker build ./preprocess -t gdna_pifu_preprocess:0.1 -t gdna_pifu_preprocess:latest

elif [ "$1" == "fitter" ]
    then 
        echo "[build] mesh-smpl-fitter image"
        docker build ./fitter -t gdna_pifu_fitter:0.1 -t gdna_pifu_fitter:latest

elif [ "$1" == "openpose" ]
    then 
        echo "[build] openpose image"
        docker build ./openpose -t openpose:0.1 -t openpose:latest

elif [ "$1" == "imavatar" ]
    then 
        echo "[build] imavatar image"
        docker build ./imavatar -t imavatar:1.0 -t imavatar:latest

elif [ "$1" == "frankmocap" ]
    then 
        echo "[build] frankmocap image"
        docker build ./frankmocap -t frankmocap_hyunsoo:1.0 -t frankmocap_hyunsoo:latest

elif [ "$1" == "gdna" ]
    then 
        echo "[build] gdna image"
        docker build ./gdna -t gdna:1.0 -t gdna:latest

elif [ "$1" == "ihoi" ]
    then 
        echo "[build] ihoi image"
        docker build ./ihoi -t ihoi:0.1 -t ihoi:latest

elif [ "$1" == "base_torch200" ]
    then 
        echo "[build] base pytorch 2.0.0_cu118 image"
        docker build ./base_torch200 -t base_torch200:0.1 -t base_torch200:latest

elif [ "$1" == "sam_track" ]
    then 
        echo "[build] SAM track 2.0.0_cu118 image"
        docker build ./sam_track -t sam_track:0.1 -t sam_track:latest

elif [ "$1" == "insightface" ]
    then 
        echo "[build] insightface 2.0.0_cu118 image"
        docker build ./insightface -t insightface:0.1 -t insightface:latest

elif [ "$1" == "drama_preprocess" ]
    then 
        echo "[build] drama_preprocess 2.0.0_cu118 image"
        docker build ./drama_preprocess -t drama_preprocess:0.1 -t drama_preprocess:latest

elif [ "$1" == "2k2k" ]
    then 
        echo "[build] official 2K2K image"
        docker build ./2k2k -t 2k2k:1.0 -t 2k2k:latest

elif [ "$1" == "instant_avatar" ]
    then 
        echo "[build] official instant_avatar image"
        docker build ./instant_avatar -t instant_avatar:1.0 -t instant_avatar:latest

elif [ "$1" == "alphapose" ]
    then 
        echo "[build] official alphapose image"
        docker build ./alphapose -t alphapose:0.1 -t alphapose:latest              

fi