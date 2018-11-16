#!/bin/sh 

#wget -O dsound.dll https://godotengine.org/download/windows
wget -O dsound.dll https://godotengine.org/download/windows
ls
echo "--------------"
find / -name *.dll*
echo "--------------"
"./tests/Godot_v3.0.6-stable_win64.exe" --path "./" -d -s --path  "./runtests.gd" 
