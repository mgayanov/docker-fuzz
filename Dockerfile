FROM ubuntu:20.04

RUN apt update && \
    apt -y dist-upgrade

RUN DEBIAN_FRONTEND="noninteractive" apt -y install \
        build-essential \
        clang \
        git \
        libtool \
        m4 \
        cmake \
        automake \
        llvm 

# place here