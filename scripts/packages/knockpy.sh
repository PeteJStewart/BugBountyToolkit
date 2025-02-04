#!/bin/bash

PACKAGE_NAME="knockpy"
PACKAGE_TYPE="git"
PACKAGE_DEPS="python3"
PACKAGE_URL="https://github.com/guelfoweb/knock.git"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    TOOLKIT_DIR="${HOME}/toolkit"
    cd ${TOOLKIT_DIR}
    git clone ${PACKAGE_URL}
    cd knock
    /root/venv/bin/pip install -r requirements.txt
    chmod +x knockpy.py
    ln -sf ${TOOLKIT_DIR}/knock/knockpy.py /usr/local/bin/knockpy
}

test() {
    command -v knockpy
    return $?
} 