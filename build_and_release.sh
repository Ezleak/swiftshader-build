#!/bin/bash
set -x
set -e
set -u

rm -rf build-release || true
mkdir -p build-release

git clone --recursive https://github.com/google/swiftshader.git
cd swiftshader
git checkout 69bc6e8ac26d38aec85946dbf1bc60c32fb6e5d3
cd ..

cd linux-out
./build
cd ..
cp linux-out/temp/*.so build-release/

cd build-release
zip -r ../swiftshader-linux.zip *
cd ..
github-release upload \
  paulthomson/swiftshader-build \
  v-${CI_BUILD_REF} \
  ${CI_BUILD_REF} \
  "$(echo -e "Automated build.\n$(git log --graph -n 3 --abbrev-commit --pretty='format:%h - %s <%an>')")" \
  'swiftshader-linux.zip'

