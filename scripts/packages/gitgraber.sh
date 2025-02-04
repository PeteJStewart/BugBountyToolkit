#!/bin/bash

PACKAGE_NAME="gitGraber"
PACKAGE_TYPE="git"
PACKAGE_DEPS="python3"
PACKAGE_URL="https://github.com/hisxo/gitGraber.git"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    TOOLKIT_DIR="${HOME}/toolkit"
    cd ${TOOLKIT_DIR}
    git clone ${PACKAGE_URL}
    cd gitGraber
    /root/venv/bin/pip install -r requirements.txt
    chmod +x gitGraber.py
    ln -sf ${TOOLKIT_DIR}/gitGraber/gitGraber.py /usr/local/bin/gitgraber
}

test() {
    command -v gitgraber
    return $?
} 