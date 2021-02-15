ros_orbslam_dockerfile
====
Docker image to use ORB-SLAM with ROS-melodic

## ORB_SLAM2
[Forked Repository](https://github.com/Shuhei-YOSHIDA/ORB_SLAM2)

To build image,
```
cd <THISREPOSITORY>
docker build -t <TAG> . # set your favorite tag
```

To start container and execute example...

host:
```
$ xhost +local:root
```

(It is assumed that Nvidia GPU is used in host and TUM-dataset is downloaded at ~/rgbd_dataset_freiburg1_xyz)
```
$ docker run -it \
    --rm \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --privileged \
    -e DISPLAY=$DISPLAY \
    --env="QT_X11_NO_MITSHM=1" \ #not necessary to execute example, but ROS's rqt
    -v ~/rgbd_dataset_freiburg1_xyz:/shared_dir \
    --runtime=nvidia \
    --device /dev/dri \
    <TAG>

# in container
$ apt install nvidia-driver-XXX # adjust as your environment
$ apt install mesa-utils
$ glxgears # If successed, example of ORBSLAM will be successed, maybe.
$ cd ~/GIT/ORB_SLAM2

# Execute example
$ ./Example/Monocular/mono_tum Vocabulary/ORBvoc.txt Examples/Monocular/TUM1.yaml /shared_dir
```

(In case without Nvidia GPU for host)
```
$ docker run -it \
    --rm \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -e DISPLAY=$DISPLAY \
    -v ~/rgbd_dataset_freiburg1_xyz:/shared_dir \
    <TAG>
```
