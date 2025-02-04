#!/bin/bash

PACKAGE_NAME="subover"
PACKAGE_TYPE="go"
PACKAGE_DEPS=""
PACKAGE_URL="github.com/Ice3man543/SubOver@latest"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    go install -v ${PACKAGE_URL}
}

test() {
    command -v SubOver
    return $?
} 