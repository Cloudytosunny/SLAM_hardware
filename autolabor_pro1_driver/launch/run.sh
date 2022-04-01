#!/bin/sh
luvcview -d /dev/video1 -f yuv -s 640x480
sudo chmod 777 /dev/ttyUSB0
source ~/catkin_autolabborPro1/devel/setup.bash
source ~/catkin_imu_wheeltec/devel/setup.bash
source ~/catkin_rssdk16/devel/setup.bash
roslaunch autolabor_pro1_driver keyboard_move.launch 
roslaunch fdilink_ahrs ahrs_driver.launch 
roslaunch rslidar_sdk start.launch 

