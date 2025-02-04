#!/bin/bash

PACKAGE_NAME="wafw00f"
PACKAGE_TYPE="pip"
PACKAGE_DEPS="python3"
PACKAGE_URL="wafw00f"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    /root/venv/bin/pip install ${PACKAGE_URL}
}

test() {
    command -v wafw00f
    return $?
} 