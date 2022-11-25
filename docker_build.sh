if [ $# -eq 0 ]
    then 
        echo "argument : docker env to run"
        
fi

if [ "$1" == "kaolin" ]
    then 
        echo "kaolin"
        docker build ./kaolin -t kaolin:0.5 -t kaolin:latest
    
elif [ "$1" == "kaolin-wisp" ]
    then
        docker build ./kaolin-wisp -t kaolin-wisp:0.2 -t kaolin-wisp:latest

elif [ "$1" == "kaolin-wisp-screen" ]
    then
        docker build ./kaolin-wisp-screen -t kaolin-wisp-screen:0.1 -t kaolin-wisp-screen:latest

elif [ "$1" == "colmap" ]
    then
        docker build ./colmap -t colmap:0.1 -t colmap:latest

elif [ "$1" == "instant-ngp" ]
    then
        docker build ./instant-ngp --no-cache -t instant-ngp:0.1 -t instant-ngp:latest

elif [ "$1" == "torch3d" ]
    then
        if [ $# -eq 2 ]
            then
                # when it specified the version
                docker build ./torch3d/torch_1.$2 -t torch3d:0.2.$2 -t torch3d:latest
        else
            # set default as 1.11
            docker build ./torch3d/torch_1.11 -t torch3d:0.2.11 -t torch3d:latest
        fi

elif [ "$1" == "banmo" ]
    then
        docker build ./banmo --no-cache -t banmo:0.4 -t banmo:latest

elif [ "$1" == "densecorres" ]
    then
        docker build ./densecorres --no-cache -t densecorres:0.2 -t densecorres:latest

elif [ "$1" == "stylgan2ada" ]
    then
        pjdir="/home/inhee/VCL/insect_recon/stylegan2-ada-pytorch"
        docker build $pjdir --tag sg2ada:latest

elif [ "$1" == "detectron2" ]
    then
        docker build ./detectron2 --no-cache --tag detectron2:0.2 --tag detectron2:latest

elif [ "$1" == "neuman_preprocess" ]
    then
        docker build ./neuman_preprocess --no-cache --tag neuman_preprocess:0.3 --tag neuman_preprocess:latest

elif [ "$1" == "pifuhd" ]
    then
        docker build ./pifuhd --no-cache --tag pifuhd:0.1 --tag pifuhd:latest

elif [ "$1" == "nerfstudio" ]
    then
        docker build ./nerfstudio --tag nerfstudio:0.2 --tag nerfstudio:latest

elif [ "$1" == "nerfacc" ]
    then
        docker build ./nerfacc --tag nerfacc:0.2 --tag nerfacc:latest

elif [ "$1" == "ngp_pl" ]
    then
        docker build ./ngp_pl --tag ngp_pl:0.1 --tag ngp_pl:latest

elif [ "$1" == "torch_ngp" ]
    then
        docker build ./torch_ngp --tag torch_ngp:0.1 --tag torch_ngp:latest

elif [ "$1" == "tcnn" ]
    then
        if [ $# -eq 2 ]
            then
                # when it specified the version
                docker build ./tcnn/cu11$2 -t tcnn:0.1.$2
        else
            # set default setting as cu116
            docker build ./tcnn/cu116 -t tcnn:0.1.6
        fi


elif [ "$1" == "frankmocap" ]
    then
        docker build ./frankmocap --tag frankmocap:0.1 --tag frankmocap:latest

else
    echo "wrong argument"
fi