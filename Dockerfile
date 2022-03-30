FROM ubuntu:20.04

ENV LC_CTYPE=C.UTF-8

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
	    ninja-build \
	    liblzma-dev \
	    libz-dev \
	    pkg-config \
	    autoconf \
        gdb

RUN mkdir -p /home/fuzzing/tools && cd /home/fuzzing/tools && \
    git clone https://github.com/AFLplusplus/AFLplusplus && \
    cd AFLplusplus && \
    make install DEBUG=1

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
        -DLIB_PROTO_MUTATOR_DOWNLOAD_PROTOBUF=ON \
        -DLIB_PROTO_MUTATOR_TESTING=OFF \
        -DCMAKE_C_COMPILER=clang \
        -DCMAKE_CXX_COMPILER=clang++ \
        -DCMAKE_C_FLAGS="-fPIC -g" \
        -DCMAKE_CXX_FLAGS="-fPIC -g" \
        -DCMAKE_BUILD_TYPE=Release && \
    make install
    
RUN cd /home/fuzzing/tools && \
    git clone https://github.com/hugsy/gef.git && \
    echo source `pwd`/gef/gef.py >> ~/.gdbinit

# place here
