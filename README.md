@[TOC](SLAM硬件搭建（激光雷达+IMU+相机+移动底盘）)

# 激光雷达
## 官方github下载安装
激光雷达采用robosense   16线  RS-LiDAR-16  
下载：
```javascript
git clone https://github.com/RoboSense-LiDAR/rslidar_sdk.git
cd rslidar_sdk
git submodule init
git submodule update
```
依赖：
Ubuntu 16.04: ros-kinetic-desktop-full
Ubuntu 18.04: ros-melodic-desktop-full
Ubuntu 20.04: ros-noetic-desktop-full

编译：
1. 打开CMakeList.txt将编译方法改为 CATKIN
```javascript
#=======================================
# Compile setup (ORIGINAL,CATKIN,COLCON)
#=======================================
set(COMPILE_METHOD CATKIN)
```
2. 打开rslidar_sdk里面的config文件夹配置里面的config.yaml，因为这个功能包包含很多类型的雷达，所以要配置成自己正在使用的雷达型号。例如RS-LiDAR-16  
```javascripe
lidar:
  - driver:
      lidar_type: RS16            #LiDAR type - RS16, RS32, RSBP, RS128, RS128_40, RS80, RSM1, RSHELIOS
      frame_id: /rslidar           #Frame id of message
      msop_port: 6699              #Msop port of lidar
      difop_port: 7788             #Difop port of lidar
      start_angle: 0               #Start angle of point cloud
      end_angle: 360               #End angle of point cloud 
      min_distance: 0.4            #Minimum distance of point cloud
      max_distance: 150            #Maximum distance of point cloud
      wait_for_difop: true         #Wait for DIFOP packet
      use_lidar_clock: false       #True--Use the lidar clock as the message timestamp
                                   #False-- Use the system clock as the timestamp
```
4. 将rslidar_sdk中的package_ros1.xml复制到同目录下命名为package.xml
5. 创建一个新的工作空间(catkin_ws)，将rslidar_sdk这个功能包复制到src这个文件夹下
6. 返回到catkin_ws文件夹下，执行以下命令进行编译
```javascript
catkin_make
source devel/setup.bash
roslaunch rslidar_sdk start.launch
```
## 从[这里](https://github.com/Cloudytosunny/SLAM_hardware)下载
从我的github下载功能包已经把上面的配置好了，直接创建一个新的工作空间(catkin_lidar)放到src进行编译(catkin_make)即可.
# IMU
## wheeltec imu n100
IMU 采用的 [wheeltec imu n100](https://detail.tmall.com/item.htm?spm=4657t.1.14.16.96184d96jPmBzk&id=645061129098&ns=1&abbucket=18)


![在这里插入图片描述](https://img-blog.csdnimg.cn/c02ef0f3ef124b6ea9b405edbff2d9a7.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAQ2xvdWR5X3RvX3N1bm55,size_25,color_FFFFFF,t_70,g_se,x_16#pic_center =400x400 )
这个IMU的功能包对应我的[github](https://github.com/Cloudytosunny/SLAM_hardware)里面的fdilink_ahrs功能包，直接克隆并创建工作空间(catkin_imu)放到src里面

**在编译之前需要运行一下脚本wheeltec_udev.sh**这个脚本的作用是确定该IMU是通过哪一个串口进行连接的。
```javascripe
sudo ./wheeltec_udev.sh
```
如果不可以，其实自己在launch文件里修改参数也可以 ，但是得知道是哪个口，可以使用这个命令查看
```javascripe
ll /dev/
```
查看外设情况
然后编译(catkin_make)，编译完运行launch文件前记得返回catkin_imu工作空间下source一下功能包,再运行launch文件
```javascripe
source devel/setup.bash 
roslaunch fdilink_ahrs ahrs_driver.launch 
```
此时就会发布以下几个话题。
```javascript
rostopic list
```

```javascript
/clock
/imu_data
/mag_pose_2d
/rosout
/rosout_agg
```
```javascript
rostopic echo /imu_data
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/fda081fc08334b40a279edfc94e7b5c6.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAQ2xvdWR5X3RvX3N1bm55,size_15,color_FFFFFF,t_70,g_se,x_16)
在打开rviz里面也可以看到imu 信息，add 话题 增加imu信息，坐标系换成imu 即可。
## xsens mti300
这里后来使用了价格更贵一点的xsens mti300 IMU
![在这里插入图片描述](https://img-blog.csdnimg.cn/8fc9de6dd8fd4c2e9707613f479b379c.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAQ2xvdWR5X3RvX3N1bm55,size_10,color_FFFFFF,t_70,g_se,x_16#pic_center)
这一款的软件套件比较简单可以直接去[官网的知识库](https://www.xsens.cn/software-downloads/)下载对应的软件套装，按照CSDN上的教程[1](https://blog.csdn.net/mr_yu_1997/article/details/120895748?ops_request_misc=&request_id=&biz_id=102&utm_term=xsens%20mti300&utm_medium=distribute.pc_search_result.none-task-blog-2~all~sobaiduweb~default-1-120895748.142^v5^pc_search_result_control_group,143^v6^register&spm=1018.2226.3001.4187)或者[2](https://blog.csdn.net/learning_tortosie/article/details/97806633?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522164853588216780269842076%2522%252C%2522scm%2522%253A%252220140713.130102334..%2522%257D&request_id=164853588216780269842076&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~sobaiduend~default-1-97806633.142^v5^pc_search_result_control_group,143^v6^register&utm_term=xsens+mti300&spm=1018.2226.3001.4187)进行学习安装

或着在我的[Github](https://github.com/Cloudytosunny/SLAM_hardware)里面下载MT_Software_Suite_linux-64_2020.5 并执行里面的mtsdk_linux-x64_2020.5sh脚本 结果会在/usr/local/xsens/下生成一些文件 其中xsens_ros_mti_driver这个文件夹就对应我的Github里面的那个功能包，把这个功能包放在新建的工作空间的src下面编译catkin_make并运行就可以发出以下话题（必须得知道使用的是哪个串口，并提升权限）

```javascript
ll /dev/
sudo chmod 777 /dev/ttyUSB0  //对应自己的USB口
source devel/setup.bash 
roslaunch xsens_mti_driver display.launch 
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/0cce92ef6edb47b3b009cd3673020cd1.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAQ2xvdWR5X3RvX3N1bm55,size_15,color_FFFFFF,t_70,g_se,x_16)
![在这里插入图片描述](https://img-blog.csdnimg.cn/8fcfbac57b224260bf683f93bb2ff045.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAQ2xvdWR5X3RvX3N1bm55,size_20,color_FFFFFF,t_70,g_se,x_16)
在MT_Software文件夹里面会有一个管理软件可以对这款imu进行设置输出以及其他参数，具体的运行方式为
```javascript
cd MT_Software_Suite_linux-x64_2020.5/
./mtmanager_linux-x64_2020.5/mtmanager/linux-x64/bin/mtmanager 

```

![在这里插入图片描述](https://img-blog.csdnimg.cn/a43c3f999d11481d9af3baf876016f18.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAQ2xvdWR5X3RvX3N1bm55,size_20,color_FFFFFF,t_70,g_se,x_16)
从这个管理器软件可以自动识别这个IMU使用的哪一个USB口，进而方便提升权限。

**注意：1.管理器软件和功能包节点不能同时运行，不然必然会有一个检测不出来设备，因为USB口已经被一个使用了  2. 管理器软件修改的参数是直接写在这个IMU里面的，写完之后在其他地方使用就可以了 3.这个管理器软件不能在ARM架构的ubuntu上运行，至少我试了，没成功，跟技术人员联系了一下，他说不能在ARM上运行，只能运行功能包，如果有人可以那就把链接发给我，谢谢**

同时我自己也试了试，在ARM架构上连功能包节点都编译不通过，因此只能另寻出路。所幸的是这家公司跟ros有合作，可以直接从ros那里下载，参考的[这里](https://blog.csdn.net/mr_yu_1997/article/details/120895748?ops_request_misc=&request_id=&biz_id=102&utm_term=xsens%20mti300&utm_medium=distribute.pc_search_result.none-task-blog-2~all~sobaiduweb~default-1-120895748.142^v5^pc_search_result_control_group,143^v6^register&spm=1018.2226.3001.4187)具体方式如下：

（1）驱动安装
```javascript
sudo apt-get install ros-kinetic-xsens-driver
```
（2）修改USB接口的权限
```javascript
sudo chmod 777 /dev/ttyUSB0//将ttyUSB0换成自己的接口名
```
（3）启动MTI设备

```javascript
roslaunch xsens_driver xsens_driver.launch
```
输出的话题为(交那个功能包少了点话题)：

![在这里插入图片描述](https://img-blog.csdnimg.cn/211590a9ab16499f80843d89e4b64c86.png)
这里有一个奇怪的问题，就是在ARM上运行后不能使用 rostopic echo /imu/data 打印信息，一打印就报错或者很卡，最终在管理器软件上修改了参数使得这个问题得到解决。具体修改后的参数为：
![在这里插入图片描述](https://img-blog.csdnimg.cn/5eb020280ace43098313f8bf60beb045.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAQ2xvdWR5X3RvX3N1bm55,size_20,color_FFFFFF,t_70,g_se,x_16)

# 移动底盘

移动底盘采用的是Autolabor Pro1(AP1)
![在这里插入图片描述](https://img-blog.csdnimg.cn/405e30d99ac0401789443d4d93546d46.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAQ2xvdWR5X3RvX3N1bm55,size_11,color_FFFFFF,t_70,g_se,x_16#pic_center)
它主要在上位机上是通过232进行控制，在我的Github里面对应autolabor_keyboard_control功能包和autolabor_porq_driver功能包后者是主要的功能包，前者是采用键盘对它进行控制的功能包

把这个两个功能包放在一个catkin_ws里面的src下面就可了，然后编译即可，记得source一下setup.bash

由于这个键盘控制的功能包不能在远程控制的软件下检测到键盘输入，即远程软件的键盘不能控制，它写的应该是直接检测硬件接口的输入，故不好使，于是我们便想到了学习ros时的小乌龟的键盘控制包，经过测试，可以在远程软件下使用，因此在autolabor_porq_driver功能包下的launch文件里面把keyboard_move.launch文件给改掉了，修改后的样子为：

```javascript
<launch>
    
    <node name="autolabor_driver" pkg="autolabor_pro1_driver" type="autolabor_pro1_driver" output="screen">
	<param name="port_name" value="/dev/ttyUSB0" />
	<param name="odom_frame" value="odom" />
	<param name="base_frame" value="base_link" />

	<param name="baud_rate" value="115200" />
	<param name="control_rate" value="10" />
	<param name="sensor_rate" value="5" />

	<param name="reduction_ratio" value="1.0" />
	<param name="encoder_resolution" value="1600.0" />

	<param name="wheel_diameter" value="0.25" />
	<param name="model_param_cw" value="0.80" />
	<param name="model_param_acw" value="0.80" />
	<param name="pid_rate" value="50.0" />
	<param name="maximum_encoding" value="32.0" />
    </node>

    <node name="control_key" pkg="turtlesim" type="turtle_teleop_key"/>
    <!--这里改了-->
</launch>
```
然后编译加source加运行的命令为：
```javascript
catkin_make
source devel/setup.bash 
roslaunch autolabor_pro1_driver keyboard_move.launch 
```
然后操作键盘就可以了
# 相机

因为要看车到底走到哪里了，所以加一个简单一点的相机查看，这里装了一个luvcview的软件，具体的教程去网上搜索就好了，在此就不多介绍了，安装好后使用命令即可打开
```javascript
luvcview -d /dev/video1 -f yuv -s 640x480
```

# 总
可以把Github里面的功能包全部clone下来然后放到一个包里，直接编译加运行，具体命令如下

```javascript
mkdir catkin_ws && cd catkin_ws
git clone https://github.com/Cloudytosunny/SLAM_hardware.git
mv SLAM_hardware/ src
cd src/
catkin_init_workspace 
cd ..
catkin_make
source devel/setup.bash 
roslaunch autolabor_pro1_driver keyboard_move.launch 
```
<kbd>Ctrl</kbd> + <kbd>Shift</kbd>+ <kbd>T</kbd>
```javascript
source devel/setup.bash 
sudo chmod 777 /dev/ttyUSB0//结合自己的USB口
roslaunch xsens_driver xsens_driver.launch//或者roslaunch fdilink_ahrs ahrs_driver.launch 
```
<kbd>Ctrl</kbd> + <kbd>Shift</kbd>+ <kbd>T</kbd>
```javascript
source devel/setup.bash 
roslaunch rslidar_sdk start.launch 
```

