FROM ubuntu:14.04

RUN \
  apt-get update && \
  apt-get -y install \
    cmake g++ make libx11-dev libxext-dev \
    git golang zip && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV \
  GOPATH=/data/gopath \
  PATH=/data/gopath/bin:${PATH}

COPY . /data/

WORKDIR /data

RUN \
  mkdir -p ${GOPATH} && \
  go get github.com/aktau/github-release

CMD ["./build_and_release.sh"]

