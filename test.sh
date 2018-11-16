#!/bin/sh 

cd wixyFun
"openSpace\tests\Godot_v3.0.6-stable_win64.exe" --path "openSpace" -d -s --path  "openSpace/runtests.gd" &>> openSpace/tests/logs/result.txt
