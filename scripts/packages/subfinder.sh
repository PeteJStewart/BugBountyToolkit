#!/bin/bash

PACKAGE_NAME="subfinder"
PACKAGE_TYPE="go"
PACKAGE_DEPS=""
PACKAGE_URL="github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"

# Include common functions directly
log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    go install -v ${PACKAGE_URL}
}

test() {
    if ! command -v subfinder &> /dev/null; then
        return 1
    fi
    return 0
}