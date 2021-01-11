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
            respuesta=error
        fi
    fi

    echo -e "$time ${color}[$respuesta]${NC} $msg"
    # if [  $respuesta = "error"  ]; then
    #     exit 1
    # fi
}

checkInternet() {
    if ping -c1 google.com &> /dev/null; then
        echo 1;
    fi

    echo 0
}

checkDir() {
    local dir=${1:?Debe proveer un argumento.}
    
    if [[ -f "$dir" ]]; then
        echo 1
    fi

    echo 0
}

log $(checkDir /etc/passwd2) Checkeando directorio
log $(checkInternet) Checkeando interntet
log $(checkDir /etc/passwd) Checkeando directorio

6 7 