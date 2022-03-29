#!/bin/bash

source ../vars

if [[ -z $1 ]] || [[ ! -d $1 ]]; then echo "check path"; exit; fi 

FZ_PATH=`realpath $1`

echo mount $FZ_PATH

UID=`id -u`
GID=`id -g`

docker run \
    --user=$UID:$GID \
    --rm \
    -ti  \
    -v $FZ_PATH:$FZ_MOUNT \
    $FZ_IMAGE \
    bash -c "cd $FZ_MOUNT && make"