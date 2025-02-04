#!/bin/bash

PACKAGE_NAME="dirsearch"
PACKAGE_TYPE="git"
PACKAGE_DEPS="python3"
PACKAGE_URL="https://github.com/maurosoria/dirsearch.git"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    TOOLKIT_DIR="${HOME}/toolkit"
    cd ${TOOLKIT_DIR}
    git clone ${PACKAGE_URL}
    cd dirsearch
    /root/venv/bin/pip install -r requirements.txt
    chmod +x dirsearch.py
    ln -sf ${TOOLKIT_DIR}/dirsearch/dirsearch.py /usr/local/bin/dirsearch
}

test() {
    command -v dirsearch
    return $?
} 