#!/bin/bash

PACKAGE_NAME="amass"
PACKAGE_TYPE="go"
PACKAGE_DEPS=""
PACKAGE_URL="github.com/owasp-amass/amass/v4/...@master"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    export GO111MODULE=on
    go install -v ${PACKAGE_URL}
}

test() {
    command -v amass
    return $?
} 