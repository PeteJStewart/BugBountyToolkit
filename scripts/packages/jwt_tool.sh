#!/bin/bash

PACKAGE_NAME="jwt_tool"
PACKAGE_TYPE="git"
PACKAGE_DEPS="python3"
PACKAGE_URL="https://github.com/ticarpi/jwt_tool.git"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    TOOLKIT_DIR="${HOME}/toolkit"
    cd ${TOOLKIT_DIR}
    git clone ${PACKAGE_URL}
    cd jwt_tool
    /root/venv/bin/pip install -r requirements.txt
    chmod +x jwt_tool.py
    ln -sf ${TOOLKIT_DIR}/jwt_tool/jwt_tool.py /usr/local/bin/jwt_tool
}

test() {
    command -v jwt_tool
    return $?
} 