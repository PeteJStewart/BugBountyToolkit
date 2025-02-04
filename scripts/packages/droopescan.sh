#!/bin/bash

PACKAGE_NAME="droopescan"
PACKAGE_TYPE="pip"
PACKAGE_DEPS="python3"
PACKAGE_URL="droopescan"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    /root/venv/bin/pip install ${PACKAGE_URL}
}

test() {
    command -v droopescan
    return $?
} 