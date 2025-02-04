#!/bin/bash

PACKAGE_NAME="wpscan"
PACKAGE_TYPE="gem"
PACKAGE_DEPS="libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev libgmp-dev zlib1g-dev"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    TOOLKIT_DIR="${HOME}/toolkit"
    cd ${TOOLKIT_DIR}
    gem install wpscan
}

test() {
    command -v wpscan
    return $?
} 