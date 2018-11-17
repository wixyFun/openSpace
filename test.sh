#!/bin/sh 

sudo apt update
sudo apt install snapd
sudo snap install godot

-s ./runtests.gd


#wget https://packages.ubuntu.com/en/trusty/scons
#wget https://packages.ubuntu.com/trusty/libx11-dev
#wget https://packages.ubuntu.com/trusty/libxcursor-dev
#wget https://packages.ubuntu.com/trusty/libxinerama-dev
#wget https://packages.ubuntu.com/trusty/libgl1-mesa-dev

#sudo apt-get install build-essential scons pkg-config libx11-dev libxcursor-dev libxinerama-dev \
   # libgl1-mesa-dev libglu-dev libasound2-dev libpulse-dev libfreetype6-dev libssl-dev libudev-dev \
    #libxi-dev libxrandr-dev

#wget -O dsound.dll https://godotengine.org/download/windows
#wget https://godotengine.org/download/linux

#"./Godot_v3.0.6-stable_win64.exe" --path "./" -d -s --path  "./runtests.gd" 

echo "inside-------------------------"
ls
#cd ..

#chmod +x gt
#chmod +x runtests.gd 

#./gt -s ./runtests.gd


