cd

sudo apt-get install ros-melodic-mavros ros-melodic-mavros-extras -y
sudo apt-get install ros-melodic-tf2-sensor-msgs ros-melodic-tf2-geometry-msgs ros-melodic-mavros* -y

wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh
sudo bash ./install_geographiclib_datasets.sh

mkdir -p ~/race_ws/src
cd ~/race_ws
catkin init
wstool init src
wstool init ~/race_ws/src

echo "source ~/race_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc

rosinstall_generator --rosdistro kinetic mavlink | tee /tmp/mavros.rosinstall
rosinstall_generator --upstream mavros | tee -a /tmp/mavros.rosinstall

wstool merge -t src /tmp/mavros.rosinstall
wstool update -t src -j4
rosdep install --from-paths src --ignore-src -y

./src/mavros/mavros/scripts/install_geographiclib_datasets.sh

catkin build

sudo apt update -y
sudo apt upgrade -y