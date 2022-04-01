# - Config file for the  package
# It defines the following variables
#  rs_driver_INCLUDE_DIRS - include directories for 
#  rs_driver_LIBRARIES    - libraries to link against
#  rs_driver_FOUND        - found flag

if(WIN32)
  if(CMAKE_SIZEOF_VOID_P EQUAL 8) # 64-bit
    set(Boost_ARCHITECTURE "-x64")
  elseif(CMAKE_SIZEOF_VOID_P EQUAL 4) # 32-bit
    set(Boost_ARCHITECTURE "-x32")
  endif()
  set(Boost_USE_STATIC_LIBS ON)
  set(Boost_USE_MULTITHREADED ON)
  set(Boost_USE_STATIC_RUNTIME OFF)
endif(WIN32)

if(${ENABLE_TRANSFORM})
  add_definitions("-DENABLE_TRANSFORM")
endif(${ENABLE_TRANSFORM})

set(rs_driver_INCLUDE_DIRS "/home/seu/wsh/catkin_lidar/src/rslidar_sdk/src/rs_driver/src;/opt/ros/melodic/include;/usr/include;/opt/ros/melodic/share/xmlrpcpp/cmake/../../../include/xmlrpcpp;/opt/ros/melodic/include;/usr/include;/usr/include;/usr/include/vtk-6.3;/usr/include/freetype2;/usr/include;/usr/lib/x86_64-linux-gnu/openmpi/include/openmpi;/usr/lib/x86_64-linux-gnu/openmpi/include/openmpi/opal/mca/event/libevent2022/libevent;/usr/lib/x86_64-linux-gnu/openmpi/include/openmpi/opal/mca/event/libevent2022/libevent/include;/usr/lib/x86_64-linux-gnu/openmpi/include;/usr/include/python2.7;/usr/include/x86_64-linux-gnu;/usr/include/hdf5/openmpi;/usr/include/libxml2;/usr/include/jsoncpp;/usr/include/tcl;/usr/include/pcl-1.8;/usr/include/eigen3;/usr/include;/usr/include/ni;/usr/include/openni2;/usr/include/vtk-6.3;/usr/include/freetype2;/usr/lib/x86_64-linux-gnu/openmpi/include/openmpi;/usr/lib/x86_64-linux-gnu/openmpi/include/openmpi/opal/mca/event/libevent2022/libevent;/usr/lib/x86_64-linux-gnu/openmpi/include/openmpi/opal/mca/event/libevent2022/libevent/include;/usr/lib/x86_64-linux-gnu/openmpi/include;/usr/include/python2.7;/usr/include/x86_64-linux-gnu;/usr/include/hdf5/openmpi;/usr/include/libxml2;/usr/include/jsoncpp;/usr/include/tcl;/home/seu/wsh/catkin_lidar/src/rslidar_sdk/src;/usr/include;/usr/local/Project/include")
set(RS_DRIVER_INCLUDE_DIRS "/home/seu/wsh/catkin_lidar/src/rslidar_sdk/src/rs_driver/src;/opt/ros/melodic/include;/usr/include;/opt/ros/melodic/share/xmlrpcpp/cmake/../../../include/xmlrpcpp;/opt/ros/melodic/include;/usr/include;/usr/include;/usr/include/vtk-6.3;/usr/include/freetype2;/usr/include;/usr/lib/x86_64-linux-gnu/openmpi/include/openmpi;/usr/lib/x86_64-linux-gnu/openmpi/include/openmpi/opal/mca/event/libevent2022/libevent;/usr/lib/x86_64-linux-gnu/openmpi/include/openmpi/opal/mca/event/libevent2022/libevent/include;/usr/lib/x86_64-linux-gnu/openmpi/include;/usr/include/python2.7;/usr/include/x86_64-linux-gnu;/usr/include/hdf5/openmpi;/usr/include/libxml2;/usr/include/jsoncpp;/usr/include/tcl;/usr/include/pcl-1.8;/usr/include/eigen3;/usr/include;/usr/include/ni;/usr/include/openni2;/usr/include/vtk-6.3;/usr/include/freetype2;/usr/lib/x86_64-linux-gnu/openmpi/include/openmpi;/usr/lib/x86_64-linux-gnu/openmpi/include/openmpi/opal/mca/event/libevent2022/libevent;/usr/lib/x86_64-linux-gnu/openmpi/include/openmpi/opal/mca/event/libevent2022/libevent/include;/usr/lib/x86_64-linux-gnu/openmpi/include;/usr/include/python2.7;/usr/include/x86_64-linux-gnu;/usr/include/hdf5/openmpi;/usr/include/libxml2;/usr/include/jsoncpp;/usr/include/tcl;/home/seu/wsh/catkin_lidar/src/rslidar_sdk/src;/usr/include;/usr/local/Project/include")

set(rs_driver_LIBRARIES "/usr/lib/x86_64-linux-gnu/libboost_system.so;/usr/lib/x86_64-linux-gnu/libboost_date_time.so;/usr/lib/x86_64-linux-gnu/libboost_regex.so;-lpthread;pthread;pcap")
set(RS_DRIVER_LIBRARIES "/usr/lib/x86_64-linux-gnu/libboost_system.so;/usr/lib/x86_64-linux-gnu/libboost_date_time.so;/usr/lib/x86_64-linux-gnu/libboost_regex.so;-lpthread;pthread;pcap")

set(rs_driver_FOUND true)
set(RS_DRIVER_FOUND true)
