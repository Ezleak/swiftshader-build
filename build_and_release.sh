#!/bin/bash
set -x
set -e
set -u

echo "Using personal token: ${GITHUB_TOKEN:0:3}..."

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

github-release \
  Ezleak/swiftshader-build \
  v-${CI_BUILD_REF} \
  ${CI_BUILD_REF} \
  "$(echo -e "Automated build.\n$(git log --graph -n 3 --abbrev-commit --pretty='format:%h - %s <%an>')")" \
  'swiftshader-android.zip'


