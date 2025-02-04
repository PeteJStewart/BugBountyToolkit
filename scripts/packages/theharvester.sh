#!/bin/bash

PACKAGE_NAME="theharvester"
PACKAGE_TYPE="git"
PACKAGE_DEPS="python3"
PACKAGE_URL="https://github.com/AlexisAhmed/theHarvester.git"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    TOOLKIT_DIR="${HOME}/toolkit"
    cd ${TOOLKIT_DIR}
    git clone ${PACKAGE_URL}
    cd theHarvester
    /root/venv/bin/pip install -r requirements.txt
    chmod +x theHarvester.py
    ln -sf ${TOOLKIT_DIR}/theHarvester/theHarvester.py /usr/local/bin/theharvester
}

test() {
    command -v theharvester
    return $?
} 