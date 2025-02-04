#!/bin/bash

PACKAGE_NAME="massdns"
PACKAGE_TYPE="git"
PACKAGE_DEPS="libldns-dev"
PACKAGE_URL="https://github.com/blechschmidt/massdns.git"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    TOOLKIT_DIR="${HOME}/toolkit"
    cd ${TOOLKIT_DIR}
    git clone ${PACKAGE_URL}
    cd massdns/
    make
    ln -sf ${TOOLKIT_DIR}/massdns/bin/massdns /usr/local/bin/massdns
}

test() {
    command -v massdns
    return $?
} 