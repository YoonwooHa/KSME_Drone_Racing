cd
git clone -b v1.13.3 https://github.com/PX4/PX4-Autopilot.git --recursive
bash ./PX4-Autopilot/Tools/setup/ubuntu.sh --no-nuttx --no-sim-tools

sudo apt update -y
sudo apt upgrade -y