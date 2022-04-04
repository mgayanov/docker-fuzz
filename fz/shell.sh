#!/bin/bash

source ../vars

if [[ -z $1 ]] || [[ ! -d $1 ]]; then echo "check path"; exit; fi 

FZ_SRC_PATH=`realpath $1`

UID=`id -u`
GID=`id -g`

docker run \
    --user=$UID:$GID \
    --rm \
    -ti  \
    -v $FZ_SRC_PATH:$FZ_SRC_MOUNT \
    $FZ_IMAGE \
    bash