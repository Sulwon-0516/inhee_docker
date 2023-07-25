# inhee_docker
Dockerfiles for 3D vision research 

You should install nvidia-docker, recent nvidia-driver and most Ampere GPUs RTX 30X0 (recommended) 

## Before build files

Lots of Dockerfile in this repo requires GPUs to build. 

You should following documents : https://stackoverflow.com/questions/59691207/docker-build-with-nvidia-runtime

1. Install nvidia-container-runtime

```
sudo apt-get install nvidia-container-runtime
```

2. Edit /etc/docker/daemon.json

```
sudo vi /etc/docker/daemon.json
```
Edit like following

```
{
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
         } 
    },
    "default-runtime": "nvidia" 
}
```

3. Restart docker daemon

```
sudo systemctl restart docker
```



## How to build

```
./docker_build.sh [name to build (same as folder name)]
```

## How to run the docker file

```
./docker_run.sh [name to build (same as folder name)] [(optional) container name]
```

- When you want to run colmap, kaolin-wisp-screen, or some docker using GUI, you should add xhost.

```
xhost +local:root
xhost +local:docker
```

- You should change dir-name to what you want in `./docker_run.sh` (the first three lines)


## Issues
### Instant-NGP
Currently, instant-ngp dockerfile doesn't work well.
It seems like it's (for me) almost impossible to build with dockerfile.
We can instead try to build instant-ngp inside container & commit to generate docker image. 

### Package/Program positions
Everythings are placed in `/home` in container
