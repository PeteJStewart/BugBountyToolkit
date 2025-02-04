#!/bin/bash

PACKAGE_NAME="virtual-host-discovery"
PACKAGE_TYPE="git"
PACKAGE_DEPS=""
PACKAGE_URL="https://github.com/AlexisAhmed/virtual-host-discovery.git"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    TOOLKIT_DIR="${HOME}/toolkit"
    cd ${TOOLKIT_DIR}
    git clone ${PACKAGE_URL}
    cd virtual-host-discovery
    chmod +x scan.rb
    ln -sf ${TOOLKIT_DIR}/virtual-host-discovery/scan.rb /usr/local/bin/virtual-host-discovery
}

test() {
    command -v virtual-host-discovery
    return $?
} 