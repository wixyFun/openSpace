#!/bin/sh 

#wget -O dsound.dll https://godotengine.org/download/windows
#wget https://godotengine.org/download/windows

#"./Godot_v3.0.6-stable_win64.exe" --path "./" -d -s --path  "./runtests.gd" 
sudo apt-get install unzip

unzip godot.zip -d godot

godot -s runtests.gd
