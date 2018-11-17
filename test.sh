#!/bin/sh 

sudo apt-get update 
#wget -O build-essential https://packages.ubuntu.com/trusty/build-essential
#wget -O scons https://packages.ubuntu.com/en/trusty/scons
#wget -O pkg-config https://packages.ubuntu.com/trusty/pkg-config
#wget -O libx11-dev https://packages.ubuntu.com/trusty/libx11-dev
#wget -O libxcursor-dev https://packages.ubuntu.com/trusty/libxcursor-dev
#wget -O libxinerama-dev  https://packages.ubuntu.com/trusty/libxinerama-dev
#wget -O libgl1-mesa-dev  https://packages.ubuntu.com/trusty/libgl1-mesa-dev
#wget -O libglu-dev https://packages.ubuntu.com/trusty/libglu-dev
#wget -O libasound2-dev https://packages.ubuntu.com/trusty/libasound2-dev
#wget -O libpulse-dev https://packages.ubuntu.com/trusty/libpulse-dev
#wget -O libfreetype6-dev https://packages.ubuntu.com/trusty/libfreetype6-dev
#wget -O libssl-dev https://packages.ubuntu.com/trusty/libssl-dev
#wget -O libudev-dev https://packages.ubuntu.com/trusty/admin/libudev-dev
#wget -O libxi-dev https://packages.ubuntu.com/trusty/libxi-dev
#wget -O libxrandr-dev https://packages.ubuntu.com/trusty/libxrandr-dev

#sudo apt-get install build-essential 
#sudo apt-get install scons 
#sudo apt-get install pkg-config 
#sudo apt-get install libx11-dev 
#sudo apt-get install libxcursor-dev 
#sudo apt-get install libxinerama-dev 
#sudo apt-get install libgl1-mesa-dev 
#sudo apt-get install libglu-dev 
#sudo apt-get install libasound2-dev 
#sudo apt-get install libpulse-dev 
#sudo apt-get install libfreetype6-dev 
#sudo apt-get install libssl-dev libudev-dev 
#sudo apt-get install libxi-dev libxrandr-dev

#sudo apt-get install p7zip-full

unzip Godot_v3.0.6-stable_x11.64.zip 

ls



#"./Godot_v3.0.6-stable_win64.exe" --path "./" -d -s --path  "./runtests.gd" 

#sudo chmod -R a+rwx  ./Godot_linux
sudo chmod -R a+rwx   ./
#cd ./Godot_linux
#ls -a


./Godot_v3.0.6-stable_x11.64 --path ./project.godot -d -s ./runtests.gd

#chmod +x gt
#chmod +x runtests.gd 

#./gt -s ./runtests.gd


