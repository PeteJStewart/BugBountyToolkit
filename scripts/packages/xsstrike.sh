#!/bin/bash

PACKAGE_NAME="xsstrike"
PACKAGE_TYPE="git"
PACKAGE_DEPS="python3"
PACKAGE_URL="https://github.com/s0md3v/XSStrike.git"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    TOOLKIT_DIR="${HOME}/toolkit"
    cd ${TOOLKIT_DIR}
    git clone ${PACKAGE_URL}
    cd XSStrike
    /root/venv/bin/pip install -r requirements.txt
    chmod +x xsstrike.py
    ln -sf ${TOOLKIT_DIR}/XSStrike/xsstrike.py /usr/local/bin/xsstrike
}

test() {
    command -v xsstrike
    return $?
} 