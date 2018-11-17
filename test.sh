#!/bin/sh 

#wget -O dsound.dll https://godotengine.org/download/windows
#wget https://godotengine.org/download/windows
wget -O libs https://directx-11.en.softonic.com/download
ls
cd libs
ls
cd ..
"./tests/Godot_v3.0.6-stable_win64.exe" --path "./" -d -s --path  "./runtests.gd" 
