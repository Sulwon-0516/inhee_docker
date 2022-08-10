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

elif [ "$1" == "banmo" ]
    then
        docker build ./banmo -t banmo:0.1 -t banmo:latest

else
    echo "wrong argument"
fi