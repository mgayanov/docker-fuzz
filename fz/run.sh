#!/bin/bash

source ../vars

if [[ -z $1 ]] || [[ ! -d $1 ]]; then echo "check path"; exit; fi 

FZ_PATH=`realpath $1`

echo mount $FZ_PATH

docker run \
    --rm \
    -ti  \
    -v $FZ_PATH:/fuzzer \
    $FZ_IMAGE \
    bash -c "cd /fuzzer && make && ./Fuzzer ./corpus"