#!/bin/sh 

#wget -O dsound.dll https://godotengine.org/download/windows
#wget https://godotengine.org/download/windows

#"./Godot_v3.0.6-stable_win64.exe" --path "./" -d -s --path  "./runtests.gd" 
sudo apt-get install unzip

#unzip gt.zip -d gt
unzip gt.zip 
cd gt

echo "inside---------------------"
ls
cd ..

chmod +x gt
chmod +x runtests.gd 

./gt -s ./runtests.gd


