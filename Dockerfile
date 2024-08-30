# Use the official Ubuntu 22.04 as the base image
FROM ubuntu:22.04


# Set non-interactive mode for APT
ARG DEBIAN_FRONTEND=noninteractive



# Update and install basic packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    sudo \
    nano \
    raspi-config \
    python3-pip \
    git \
    cmake \
    build-essential




# Install MAVProxy
RUN pip3 install mavproxy


# Remove modemmanager
RUN apt-get remove -y modemmanager


# Set up the configuration files
# RUN echo "enable_uart=1" >> /boot/firmware/config.txt && \
#     echo "dtoverlay=disable-bt" >> /boot/firmware/config.txt


# Clone and install the Micro XRCE-DDS Agent
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    build-essential \
    libssl-dev \
    wget  # Install wget here if you need it later

RUN git clone https://github.com/eProsima/Micro-XRCE-DDS-Agent.git && \
    cd Micro-XRCE-DDS-Agent && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    sudo make install && \
    sudo ldconfig /usr/local/lib/


# Set up the ROS 2 Humble environment
RUN apt-get update && apt-get install -y \
    locales \
    curl && \
    locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add - && \
    sh -c 'echo "deb http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list' && \
    apt-get update && \
    apt-get install -y ros-humble-desktop


# Source ROS 2 setup script
# RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc


# Expose the necessary ports
EXPOSE 14550


# Set up the entrypoint
ENTRYPOINT ["bash"]


### Commands added after starting downloads:

# Install PX4
RUN git clone https://github.com/PX4/PX4-Autopilot.git --recursive
RUN bash ./PX4-Autopilot/Tools/setup/ubuntu.sh

# Question: if I need to restart the container here for the bash commands found online,
# what's the best way to do that?

# Install MAVLink test items
RUN git clone https://github.com/FredJones4/testMavlink.git

RUN pip3 install kconfiglib

# Q Ground Control
RUN sudo apt-get update
RUN sudo apt-get install wget
RUN wget https://d176tv9ibo4jno.cloudfront.net/latest/QGroundControl.AppImage
RUN chmod +x QGroundControl.AppImage


# Install Christian Hales's ROS 2 PX4 Interface code.
RUN git clone https://github.com/FredJones4/vtol_ctrl_ros2.git
# Because it's a helpful tool, and it works on all 3 main OSs (Windows, MacOS, Ubuntu), I'll add my database item.
RUN git clone https://github.com/FredJones4/servo_db_acess.git





