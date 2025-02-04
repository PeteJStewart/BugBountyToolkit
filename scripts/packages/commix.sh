#!/bin/bash

PACKAGE_NAME="commix"
PACKAGE_TYPE="git"
PACKAGE_DEPS=""
PACKAGE_URL="https://github.com/commixproject/commix.git"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    TOOLKIT_DIR="${HOME}/toolkit"
    cd ${TOOLKIT_DIR}
    git clone ${PACKAGE_URL}
    cd commix
    chmod +x commix.py
    ln -sf ${TOOLKIT_DIR}/commix/commix.py /usr/local/bin/commix
}

test() {
    command -v commix
    return $?
} 