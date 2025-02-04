#!/bin/bash

PACKAGE_NAME="whatweb"
PACKAGE_TYPE="git"
PACKAGE_DEPS=""
PACKAGE_URL="https://github.com/urbanadventurer/WhatWeb.git"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    TOOLKIT_DIR="${HOME}/toolkit"
    cd ${TOOLKIT_DIR}
    git clone ${PACKAGE_URL}
    cd WhatWeb
    chmod +x whatweb
    ln -sf ${TOOLKIT_DIR}/WhatWeb/whatweb /usr/local/bin/whatweb
}

test() {
    command -v whatweb
    return $?
} 