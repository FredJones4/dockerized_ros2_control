## Current time required to create image on ground computer:
```
1389.7 s (or 23 min 10 s)
```

```
sudo docker build -t test1 .
[+] Building 1389.7s (21/21) FINISHED                                                                                                                                                           	docker:default
 => [internal] load build definition from Dockerfile                                                                                                                                                      	0.0s
 => => transferring dockerfile: 4.04kB                                                                                                                                                                    	0.0s
 => [internal] load metadata for docker.io/library/ubuntu:22.04                                                                                                                                           	1.2s
 => [internal] load .dockerignore                                                                                                                                                                         	0.0s
 => => transferring context: 2B                                                                                                                                                                           	0.0s
 => [ 1/17] FROM docker.io/library/ubuntu:22.04@sha256:adbb90115a21969d2fe6fa7f9af4253e16d45f8d4c1e930182610c4731962658                                                                                   	0.1s
 => => resolve docker.io/library/ubuntu:22.04@sha256:adbb90115a21969d2fe6fa7f9af4253e16d45f8d4c1e930182610c4731962658                                                                                     	0.0s
 => => sha256:adbb90115a21969d2fe6fa7f9af4253e16d45f8d4c1e930182610c4731962658 1.34kB / 1.34kB                                                                                                            	0.0s
 => => sha256:075680e983398fda61b1ac59ad733ad81d18df4bc46411666bb8a03fb9ea0195 424B / 424B                                                                                                                	0.0s
 => => sha256:53a843653cbcd9e10be207e951d907dc2481d9c222de57d24cfcac32e5165188 2.30kB / 2.30kB                                                                                                            	0.0s
 => [ 2/17] RUN apt-get update && apt-get upgrade -y && apt-get install -y 	sudo 	nano 	raspi-config 	python3-pip 	git 	cmake 	build-essential                                      	69.8s
 => [ 3/17] RUN pip3 install mavproxy                                                                                                                                                                    	14.6s
 => [ 4/17] RUN apt-get remove -y modemmanager                                                                                                                                                            	1.4s
 => [ 5/17] RUN apt-get update && apt-get install -y 	git 	cmake 	build-essential 	libssl-dev 	wget  # Install wget here if you need it later                                              	5.6s
 => [ 6/17] RUN git clone https://github.com/eProsima/Micro-XRCE-DDS-Agent.git && 	cd Micro-XRCE-DDS-Agent && 	mkdir build && 	cd build && 	cmake .. && 	make && 	sudo make install &&	709.9s
 => [ 7/17] RUN apt-get update && apt-get install -y 	locales 	curl && 	locale-gen en_US en_US.UTF-8 && 	update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && 	curl -sSL https://raw.github  287.3s
 => [ 8/17] RUN git clone https://github.com/PX4/PX4-Autopilot.git --recursive                                                                                                                           	88.9s
 => [ 9/17] RUN bash ./PX4-Autopilot/Tools/setup/ubuntu.sh                                                                                                                                              	133.9s
 => [10/17] RUN git clone https://github.com/FredJones4/testMavlink.git                                                                                                                                   	1.3s
 => [11/17] RUN pip3 install kconfiglib                                                                                                                                                                   	1.0s
 => [12/17] RUN sudo apt-get update                                                                                                                                                                       	2.1s
 => [13/17] RUN sudo apt-get install wget                                                                                                                                                                 	1.4s
 => [14/17] RUN wget https://d176tv9ibo4jno.cloudfront.net/latest/QGroundControl.AppImage                                                                                                                 	2.9s
 => [15/17] RUN chmod +x QGroundControl.AppImage                                                                                                                                                          	0.8s
 => [16/17] RUN git clone https://github.com/FredJones4/vtol_ctrl_ros2.git                                                                                                                                	6.2s
 => [17/17] RUN git clone https://github.com/FredJones4/servo_db_acess.git                                                                                                                                	4.7s
 => exporting to image                                                                                                                                                                                   	56.2s
 => => exporting layers                                                                                                                                                                                  	56.2s
 => => writing image sha256:b47871f0be671b795358cca901f592675c3d51efa322816fc9d7aa08b9b4eb6f                                                                                                              	0.0s
 => => naming to docker.io/library/test1                                                                                                                                                                  	0.0s



```

## Current size of created image:

```
9.28 GB
```


# Setup instructions:

1. Go to dockerized_ros2_control directory.
```
cd ~/dockerized_ros2_control
```
2.
```
sudo docker build -t test1 .
```
Replace ```test1``` with the desired name of the image.

3. Non USB-version:
```
sudo xhost +local:root
sudo docker run -it --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --name cmhales3 dockerized_ros2_control

```
Replace ```cmhales3``` with the desired name of the container.

USB Version:
```
sudo docker run -it --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" -v /dev/usb_to_mount:/dev/USB --privileged --name cmhales3 dockerized_ros2_control
```


**TODO: add all this into the compose.yaml**

# Future

Compose instructions:

1. Go to dockerized_ros2_control directory.
```
cd ~/dockerized_ros2_control
```
2. 
``` 
sudo docker compose build
```
3. 
```
sudo docker run dean_Christian_summer2024
```

**TODO: confirm correct usage of Step 3.**




# Resources
https://docs.rosflight.org/git-main/user-guide/ros2-setup/#using-a-docker-container-to-run-ros2:~:text=To%20give%20access%20to%20the%20host%27s%20windowing%20system%2C%20use%20the%20following%20commands.%20Note%20that%20the%20base%20Docker%20image%20is%20osrf/ros%3Ahumble%2Ddesktop%2Dfull%2C%20as%20ros%3Ahumble%20doesn%27t%20include%20GUI%20tools%20in%20the%20image.%20Also%2C%20xhost%20%2Blocal%3Aroot%20needs%20to%20be%20run%20once%20per%20login%20session%20and%20is%20not%20persistent 

https://github.com/byu-magicc/docker-ros-demo

https://roboticseabass.com/2021/04/21/docker-and-ros/ 

