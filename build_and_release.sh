#!/bin/bash
set -x
set -e
set -u

git clone https://github.com/google/swiftshader.git
cd swiftshader
git checkout $(cat ../COMMIT_ID)
git submodule init
git submodule update
cd ..

cd Android-out
./build
mkdir -p release/lib		
cp temp/*.so release/lib		
cp -R ../swiftshader/include release/		
rm -rf release/include/Direct3D		

cd release		
zip -r ../swiftshader-android.zip *		
cd ..		

