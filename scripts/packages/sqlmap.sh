#!/bin/bash

PACKAGE_NAME="sqlmap"
PACKAGE_TYPE="git"
PACKAGE_DEPS=""
PACKAGE_URL="https://github.com/sqlmapproject/sqlmap.git"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    TOOLKIT_DIR="${HOME}/toolkit"
    cd ${TOOLKIT_DIR}
    git clone ${PACKAGE_URL}
    cd sqlmap
    chmod +x sqlmap.py
    ln -sf ${TOOLKIT_DIR}/sqlmap/sqlmap.py /usr/local/bin/sqlmap
}

test() {
    command -v sqlmap
    return $?
} 