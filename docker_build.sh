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
        docker build ./banmo --no-cache -t banmo:0.2 -t banmo:latest

else
    echo "wrong argument"
fi