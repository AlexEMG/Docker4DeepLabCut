# Docker Environment for DeepLabCut

This package will allow you to run [DeepLabCut](https://github.com/AlexEMG/DeepLabCut) with everything pre-installed inside a Docker container.

This Docker file is based off the [Bethge lab container](https://github.com/bethgelab/docker). Specifically, the one we provide comes with **Ubuntu 14.04 + Cuda 8.0 + CuDNN v5** and **Tensorflow 1.2** (ideal for the current version of [DeepLabCut](https://github.com/AlexEMG/DeepLabCut)), and the required python packages.


NOTE: [this container does not work on windows hosts!](https://github.com/NVIDIA/nvidia-docker/issues/43)

## Prerequisites

**(1)** Install Docker. See https://docs.docker.com/install/ & for Ubuntu: https://docs.docker.com/install/linux/docker-ce/ubuntu/

**(2)** Install nvidia-docker, see https://github.com/nvidia/nvidia-docker/wiki/Installation-(version-1.0). Specifically for linux follow, https://nvidia.github.io/nvidia-docker/.
But, basically it is just: 

    $ sudo apt-get install nvidia-docker
    
**TIP:**
You can test your nvidia-docker installation by running:
```
nvidia-docker run --rm nvidia/cuda nvidia-smi
```
**(3)** Add your user to the docker group (https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user)
Quick guide  to create the docker group and add your user: 
Create the docker group.

    $ sudo groupadd docker
Add your user to the docker group.

    $ sudo usermod -aG docker $USER

(perhaps open a new terminal to make sure that you are added from now on)
Lastly, install the Docker and DeepLabCut: 
```
git clone https://github.com/AlexEMG/Docker4DeepLabCut
git clone https://github.com/AlexEMG/DeepLabCut
cd Docker4DeepLabCut
```

## Step-by-step instructions for creating the Docker environment

Next create the image. The image needs only be created **once**. All the required software will be downloaded from DockerHub. (you can pick a user name and container name other than dlc_user/dlc_tf1.2 if you want):
```
docker image build -t dlc_user/dlc_tf1.2 .
```

## Starting the docker container from your image (de-novo):

In the terminal start your container with the following command (in the DockerContainer4DeepLabCut folder):

Options: 
- change port: (i.e. 2351 can be 777, etc)
- change which GPU to use (check which GPU you want to use in the terminal by running "nvidia-smi")
- change the name: --name alex_GPU1 (i.e. alex_GPU1 can be anything you want)
- change the home fodler:-e USER_HOME=$HOME/DeepLabCut  (i.e. this can be -e USER_HOME=$HOME/whateveryouwant)

```
GPU=1 bash ./dlc-docker run -d -p 2351:8888 -e USER_HOME=$HOME/DeepLabCut --name alex_GPU1 dlc_user/dlc_tf1.2
```
Do not run this with sudo. Now you can enter your container in the terminal, or via a browser interface: 

 - Enter the container via the terminal (to get terminal access in container):
```
docker exec -it alex_GPU1 /bin/bash
```
Access your linked (internal home) directory:
```
cd ../../../home/
```
- Enter the container via a browser interface (i.e Jupyter Notebook):

Go to the port you specified, i.e. in our example enter http://localhost:2351 in Google Chrome.
Get the token: in the terminal look at the docker log; copy and paste the value after "token=":

    $ docker logs alex_GPU1 
  

Now you have an Ubuntu with **Python3** and a GPU-installed with **Tensorflow 1.2**, and all the other dependencies ... installed! Happy DeepLabCutting! 

# Docker Quick Tips:
Check which containers are running:

    $ docker ps 
You can stop a container: 

    $ docker stop alex_GPU1 

You can re-start your container:

    $ docker start alex_GPU1

After stopping you can remove old containers: 

    $ docker rm alex_GPU1

(once removed, it can be created again): 
```
GPU=1 bash ./dlc-docker run -d -p 2351:8888 -e USER_HOME=$HOME/DeepLabCut --name alex_GPU1 dlc_user/dlc_tf1.2
```

# DeepLabCut Quick Training Guide & Evaluation Tips can be found on the [DeepLabCut Wiki]( https://github.com/AlexEMG/DeepLabCut/wiki)
