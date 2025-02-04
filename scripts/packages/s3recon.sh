#!/bin/bash

PACKAGE_NAME="s3recon"
PACKAGE_TYPE="pip"
PACKAGE_DEPS="python3"
PACKAGE_URL="s3recon"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    /root/venv/bin/pip install --upgrade setuptools
    /root/venv/bin/pip install pyyaml pymongo requests ${PACKAGE_URL}
}

test() {
    command -v s3recon
    return $?
} 