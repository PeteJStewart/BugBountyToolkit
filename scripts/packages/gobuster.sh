#!/bin/bash

PACKAGE_NAME="gobuster"
PACKAGE_TYPE="go"
PACKAGE_DEPS=""
PACKAGE_URL="github.com/OJ/gobuster/v3@latest"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    go install ${PACKAGE_URL}
}

test() {
    command -v gobuster
    return $?
} 