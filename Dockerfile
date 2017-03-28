FROM ubuntu:14.04

RUN \
  apt-get update && \
  apt-get -y install \
    cmake g++ make libx11-dev libxext-dev \
    git zip wget tar && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV PATH=/data/bin/linux/amd64:${PATH}

COPY . /data/

WORKDIR /data

RUN \
  wget https://github.com/aktau/github-release/releases/download/v0.7.0/linux-amd64-github-release.tar.bz2 && \
  tar -xf linux-amd64-github-release.tar.bz2

CMD ["./build_and_release.sh"]

