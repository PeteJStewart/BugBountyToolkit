#!/bin/bash

PACKAGE_NAME="cloudflair"
PACKAGE_TYPE="git"
PACKAGE_DEPS="python3"
PACKAGE_URL="https://github.com/christophetd/CloudFlair.git"

install() {
    log "Installing ${PACKAGE_NAME}"
    cd ${TOOLKIT_DIR}
    git clone ${PACKAGE_URL}
    cd CloudFlair
    install_pip_package -r requirements.txt
    chmod +x cloudflair.py
    ln -sf ${TOOLKIT_DIR}/CloudFlair/cloudflair.py /usr/local/bin/cloudflair
}

test() {
    command -v cloudflair
    return $?
} 