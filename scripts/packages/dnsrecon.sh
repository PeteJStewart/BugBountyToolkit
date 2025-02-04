#!/bin/bash

PACKAGE_NAME="dnsrecon"
PACKAGE_TYPE="apt"
PACKAGE_DEPS=""

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends dnsrecon
    rm -rf /var/lib/apt/lists/*
}

test() {
    command -v dnsrecon
    return $?
} 