#!/bin/sh 

wget -O build-essential https://packages.ubuntu.com/trusty/build-essential
wget -O scons https://packages.ubuntu.com/en/trusty/scons
     -O pkg-config
wget -O libx11-dev https://packages.ubuntu.com/trusty/libx11-dev
wget -O libxcursor-dev https://packages.ubuntu.com/trusty/libxcursor-dev
wget -O libxinerama-dev  https://packages.ubuntu.com/trusty/libxinerama-dev
wget -O libgl1-mesa-dev  https://packages.ubuntu.com/trusty/libgl1-mesa-dev
wget -O libglu-dev https://packages.ubuntu.com/trusty/libglu-dev
wget -O libasound2-dev https://packages.ubuntu.com/trusty/libasound2-dev
wget -O libpulse-dev https://packages.ubuntu.com/trusty/libpulse-dev
wget -O libfreetype6-dev https://packages.ubuntu.com/trusty/libfreetype6-dev
wget -O libssl-dev https://packages.ubuntu.com/trusty/libssl-dev
wget -O libudev-dev https://packages.ubuntu.com/trusty/admin/libudev-dev
wget -O libxi-dev https://packages.ubuntu.com/trusty/libxi-dev
wget -O libxrandr-dev https://packages.ubuntu.com/trusty/libxrandr-dev

sudo apt-get install build-essential scons pkg-config libx11-dev libxcursor-dev libxinerama-dev \
   libgl1-mesa-dev libglu-dev libasound2-dev libpulse-dev libfreetype6-dev libssl-dev libudev-dev \
   libxi-dev libxrandr-dev

#wget -O dsound.dll https://godotengine.org/download/windows
#wget https://godotengine.org/download/linux

#"./Godot_v3.0.6-stable_win64.exe" --path "./" -d -s --path  "./runtests.gd" 

echo "inside-------------------------"
ls
#cd ..

#chmod +x gt
#chmod +x runtests.gd 

#./gt -s ./runtests.gd


