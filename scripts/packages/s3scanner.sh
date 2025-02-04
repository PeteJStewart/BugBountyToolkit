#!/bin/bash

PACKAGE_NAME="s3scanner"
PACKAGE_TYPE="go"
PACKAGE_DEPS=""
PACKAGE_URL="github.com/sa7mon/s3scanner@latest"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    go install -v ${PACKAGE_URL}
}

test() {
    command -v s3scanner
    return $?
} 