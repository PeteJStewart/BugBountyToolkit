#!/bin/bash

PACKAGE_NAME="sublist3r"
PACKAGE_TYPE="git"
PACKAGE_DEPS="python3"
PACKAGE_URL="https://github.com/aboul3la/Sublist3r.git"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    TOOLKIT_DIR="${HOME}/toolkit"
    cd ${TOOLKIT_DIR}
    git clone ${PACKAGE_URL}
    cd Sublist3r/
    /root/venv/bin/pip install -r requirements.txt
    ln -s ${TOOLKIT_DIR}/Sublist3r/sublist3r.py /usr/local/bin/sublist3r
}

test() {
    command -v sublist3r
    return $?
} 