#!/bin/sh 

wget https://www.dll-files.com/download/12a02960e0686ee3585a0ac5eb836699/dsound.dll.html?c=M1d0azFMUWVBZ1d5V1ZrdUZyUUhsdz09

"./tests/Godot_v3.0.6-stable_win64.exe" --path "./" -d -s --path  "./runtests.gd" 
