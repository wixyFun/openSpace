#!/bin/sh
cd $TRAVIS_BUILD_DIR/
"openSpace\tests\Godot_v3.0.6-stable_win64.exe" --path "openSpace" -d -s --path  "openSpace/addons/gut/gut_cmdln.gd" &>> openSpace/tests/logs/result.txt