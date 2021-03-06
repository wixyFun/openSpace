#!/bin/bash -e

sudo apt-get update 

sudo apt-get install -y build-essential 
sudo apt-get install -y scons 
sudo apt-get install -y cppcheck
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


unzip Godot_v3.0.6-stable_linux_headless.64.zip 

ls

#sudo chmod -R a+rwx  ./Godot_linux
chmod -R +x ./Godot_v3.0.6-stable_linux_headless.64
#ls -a
#./Godot_v3.0.6-stable_linux_headless.64 --path ./project.godot -d -s ./runtests.gd
./Godot_v3.0.6-stable_linux_headless.64 --path ./project.godot -d -s ./tests/menu/runtests.gd

pushd godot-cpp
scons platform=linux generate_bindings=yes
popd

scons platform=linux