
FROM ros:melodic-perception

# always run at initializing OS
RUN apt-get update && apt-get install -y

# Files cloned from github are put on ~/GIT
RUN cd && mkdir GIT

# install Pangolin
RUN cd ~/GIT/ && git clone https://github.com/stevenlovegrove/Pangolin.git
RUN apt-get install -y libgl1-mesa-dev # already installed
RUN apt-get install -y libglew-dev
RUN apt-get install -y cmake # already installed

RUN cd ~/GIT/Pangolin && \
    mkdir build && cd build && \
    cmake .. && cmake --build .

# install ORB_SLAM2
RUN cd ~/GIT && git clone https://github.com/Shuhei-YOSHIDA/ORB_SLAM2.git ORB_SLAM2
RUN cd ~/GIT/ORB_SLAM2 && \
    chmod +x ./build.sh && ./build.sh

# build ROS node example
SHELL ["/bin/bash", "-c"]
RUN cd ~/GIT/ORB_SLAM2 && \
    source /opt/ros/$ROS_DISTRO/setup.bash&& \
    export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:/root/GIT/ORB_SLAM2/Examples/ROS && \
    echo $ROS_PACKAGE_PATH && \
    chmod +x ./build_ros.sh && ./build_ros.sh
