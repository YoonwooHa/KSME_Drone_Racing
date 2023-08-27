cd

sudo apt-get install ros-noetic-mavros ros-noetic-mavros-extras -y
sudo apt-get install ros-noetic-tf2-sensor-msgs ros-noetic-tf2-geometry-msgs ros-noetic-mavros* -y

wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh
sudo bash ./install_geographiclib_datasets.sh

mkdir -p ~/race_ws/src
cd ~/race_ws
catkin init
wstool init src

rosinstall_generator --rosdistro kinetic mavlink | tee /tmp/mavros.rosinstall
rosinstall_generator --upstream mavros | tee -a /tmp/mavros.rosinstall

wstool merge -t src /tmp/mavros.rosinstall
wstool update -t src -j4
rosdep install --from-paths src --ignore-src --rosdistro noetic -y --os ubuntu:focal

sudo apt install geographiclib-tools -y
install_geo=$(wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh -O -)
wget_return_code=$?
sudo bash -c "$install_geo"

catkin build
echo "source ~/race_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc

sudo apt update -y
sudo apt upgrade -y