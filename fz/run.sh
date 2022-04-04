#!/bin/bash

source ../vars

if [[ -z $1 ]] || [[ ! -d $1 ]]; then echo "check fz src path"; exit; fi 

if [[ -z $2 ]] || [[ ! -d $2 ]]; then echo "check target src path"; exit; fi 

FZ_SRC_PATH=`realpath $1`
TARGET_SRC_PATH=`realpath $2`
OUT_PATH=$FZ_SRC_PATH/out

UID=`id -u`
GID=`id -g`

if [[ ! -d $OUT_PATH ]]; then mkdir $OUT_PATH && sudo mount -t tmpfs -o uid=$UID,gid=$GID tmpfs $OUT_PATH; fi

docker run \
    --user=$UID:$GID \
    --rm \
    -ti  \
    -v $FZ_SRC_PATH:$FZ_SRC_MOUNT \
    -v $TARGET_SRC_PATH:$FZ_TARGET_MOUNT \
    $FZ_IMAGE \
    bash -c "cd $FZ_SRC_MOUNT && make"