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
