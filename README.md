**TEKNOFEST 2022 Fighter UAV**

### Starting Simulation
**Works on Ubuntu 20.04 and Upper Versions**

![Screenshot from 2021-12-30 03-12-38](https://user-images.githubusercontent.com/95924647/147712191-079258bf-4ea4-46f1-93d9-c05a3170d36e.png)
![Screenshot from 2021-12-30 03-13-00](https://user-images.githubusercontent.com/95924647/147712195-4ad85769-c441-4ceb-9a79-1a6f10149bfc.png)
![Screenshot from 2021-12-30 03-15-05](https://user-images.githubusercontent.com/95924647/147712197-1e42b3a2-bc0e-4126-a29f-7b50ee38363d.png)
````
bash ~/test-ucusu/fighter-sim/start.sh
````
![Screenshot from 2022-03-14 21-40-02](https://user-images.githubusercontent.com/95924647/158239630-4b3a402f-ad2e-40d7-9458-d540f8ccccb6.png)
![Screenshot from 2022-03-14 21-40-12](https://user-images.githubusercontent.com/95924647/158239644-a23d3534-9989-4aa1-abb6-3d97c00efb5f.png)


## Install Simulation:

**System Requisite:**

Gazebo 11 and ROS Noetic

Ardupilot SITL

Ardupilot Gazebo Pack

**Step 1 - Install Requisite List**
````
sudo apt-get install cmake curl git gitk git-gui python3-pip screen apt-transport-https -y
````
````
sudo sh \
    -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" \
        > /etc/apt/sources.list.d/ros-latest.list'
````
````
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get install python3-catkin-tools -y
sudo pip install dronekit
sudo pip3 install -U catkin_tools
````


**Step 2 - Install Ardupilot SITL**
````
cd
git clone https://github.com/ArduPilot/ardupilot.git
````
````
cd ardupilot
git submodule update --init --recursive
````
````
Tools/environment_install/install-prereqs-ubuntu.sh -y
. ~/.profile
````
**Necessary for true PID settings**
````
rm ~/ardupilot/Tools/autotest/default_params/plane.parm
touch ~/ardupilot/Tools/autotest/default_params/plane.parm
````
**Step 3 - Install Ardupilot Gazebo Pack**
````
cd
mkdir test-ucusu
cd ~/test-ucusu
git clone https://github.com/test-ucusu/fighter-sim.git
````
````
cd ~/test-ucusu/fighter-sim
mkdir build
cd build
cmake ..
make -j8
sudo make install
````

Set Path of Gazebo Models / Worlds...
Open up .bashrc
````
sudo gedit ~/.bashrc
````
Copy & Paste Followings at the end of .bashrc file
````
source /usr/share/gazebo/setup.sh
source /opt/ros/noetic/setup.bash
export GAZEBO_RESOURCE_PATH=~/test-ucusu/fighter-sim/worlds:${GAZEBO_RESOURCE_PATH}
export GAZEBO_PLUGIN_PATH=~/test-ucusu/fighter-sim/build:${GAZEBO_PLUGIN_PATH}
export GAZEBO_MODEL_PATH=~/test-ucusu/fighter-sim/models:${GAZEBO_MODEL_PATH}
````

**Step 4 - Install ROS and Gazebo**
````
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update
````
````
sudo apt install ros-noetic-desktop-full ros-noetic-web-video-server -y
````
````
export ROS_PACKAGE_PATH=/home/$USER/test-ucusu/fighter-sim/worlds:/opt/ros/hydro/share:/opt/ros/hydro/stacks:$ROS_PACKAGE_PATH
````
**Step 5 - Install ROS Video Server**
````
cd
mkdir catkin
cd catkin
mkdir src
cd src
git clone https://github.com/sfalexrog/async_web_server_cpp.git -b noetic-devel
git clone https://github.com/RobotWebTools/web_video_server.git
cd ..
catkin build
sudo apt install python3-roslaunch -y
````

