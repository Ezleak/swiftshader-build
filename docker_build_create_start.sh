#!/bin/sh
set -e
set -x
set -u

IMAGE=swiftshader-build-image
CONTAINER=swiftshader-build-container

docker build -t ${IMAGE} .

docker stop ${CONTAINER} || true
docker rm ${CONTAINER} || true

docker create -e CI_BUILD_REF -e GITHUB_TOKEN -ti --name ${CONTAINER} ${IMAGE} ./build_and_release.sh
docker start -a ${CONTAINER}

