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
        llvm \
	gcc-9-plugin-dev \
	protobuf-compiler \
	ninja-build \
	liblzma-dev \
	libz-dev \
	pkg-config \
	autoconf 

RUN mkdir -p /home/fuzzing/tools && cd /home/fuzzing/tools && \
    git clone https://github.com/AFLplusplus/AFLplusplus && \
    cd AFLplusplus && \
    make install

# https://github.com/google/libprotobuf-mutator/blob/master/README.md
# /usr/local/lib/libprotobuf-mutator.a
# /usr/local/lib/libprotobuf-mutator-libfuzzer.a
# /home/fuzzing/tools/libprotobuf-mutator/build/external.protobuf/lib/libprotobuf.a
RUN cd /home/fuzzing/tools && \
    git clone https://github.com/google/libprotobuf-mutator && \
    cd libprotobuf-mutator && \
    mkdir build && \
    cd build && \
    cmake .. \
        -GNinja \
        -DLIB_PROTO_MUTATOR_DOWNLOAD_PROTOBUF=ON \
        -DLIB_PROTO_MUTATOR_TESTING=OFF \
        -DCMAKE_C_COMPILER=clang \
        -DCMAKE_CXX_COMPILER=clang++ \
        -DCMAKE_BUILD_TYPE=Release && \
    ninja && \
    ninja install

# place here
