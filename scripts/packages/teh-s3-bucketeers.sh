#!/bin/bash

PACKAGE_NAME="teh_s3_bucketeers"
PACKAGE_TYPE="git"
PACKAGE_DEPS=""
PACKAGE_URL="https://github.com/tomdev/teh_s3_bucketeers.git"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    TOOLKIT_DIR="${HOME}/toolkit"
    cd ${TOOLKIT_DIR}
    git clone ${PACKAGE_URL}
    cd teh_s3_bucketeers
    chmod +x bucketeer.sh
    ln -sf ${TOOLKIT_DIR}/teh_s3_bucketeers/bucketeer.sh /usr/local/bin/bucketeer
}

test() {
    command -v bucketeer
    return $?
} 