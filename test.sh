#!/bin/sh 

# cd wixyFun
ls
".\tests\Godot_v3.0.6-stable_win64.exe" --path "openSpace" -d -s --path  "./runtests.gd" &>> ./tests/logs/result.txt
