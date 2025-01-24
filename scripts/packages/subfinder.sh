#!/bin/bash

PACKAGE_NAME="subfinder"
PACKAGE_TYPE="go"
PACKAGE_DEPS=""
PACKAGE_URL="github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"

install() {
    log "Installing ${PACKAGE_NAME}"
    install_go_package ${PACKAGE_URL}
}

test() {
    if ! command -v subfinder &> /dev/null; then
        return 1
    fi
    return 0
}