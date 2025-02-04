#!/bin/bash

PACKAGE_NAME="masscan"
PACKAGE_TYPE="git"
PACKAGE_DEPS="libpcap-dev"
PACKAGE_URL="https://github.com/robertdavidgraham/masscan.git"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    TOOLKIT_DIR="${HOME}/toolkit"
    cd ${TOOLKIT_DIR}
    git clone ${PACKAGE_URL}
    cd masscan
    make
    ln -sf ${TOOLKIT_DIR}/masscan/bin/masscan /usr/local/bin/masscan
}

test() {
    command -v masscan
    return $?
} 