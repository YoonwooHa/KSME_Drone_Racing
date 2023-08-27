cd
git clone -b v1.8.1 https://github.com/Microsoft/AirSim.git
cd AirSim

./setup.sh
./build.sh

sudo apt-get install ros-noetic-tf2-sensor-msgs ros-noetic-tf2-geometry-msgs ros-noetic-mavros* -y

cd ~/AirSim/ros
catkin build

echo "source ~/AirSim/ros/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc

sudo apt update -y
sudo apt upgrade -y