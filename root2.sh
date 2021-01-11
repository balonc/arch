#!/bin/bash

RED='\033[0;31m'
BLUE="\033[0;34m"
GREEN="\033[0;32m"
NC='\033[0m' # No Color

log() {
    respuesta=$1
    msg=$2
    time=$(date '+%d/%m/%Y %H:%M:%S')
    color=$BLUE

    if [  $respuesta == 1  ]; then
        color=$GREEN
        respuesta=ok
    else 
        if [  $respuesta == 0  ]; then
            color=$RED
            respuesta=nok
        fi
    fi

    echo -e "$time ${color}[$respuesta]${NC} $msg"
    # if [  $respuesta = "error"  ]; then
    #     exit 1
    # fi
}
