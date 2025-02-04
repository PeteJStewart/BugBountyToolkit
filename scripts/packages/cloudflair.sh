#!/bin/bash

PACKAGE_NAME="cloudflair"
PACKAGE_TYPE="git"
PACKAGE_DEPS="python3"
PACKAGE_URL="https://github.com/christophetd/CloudFlair.git"

# Include necessary functions directly
log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    TOOLKIT_DIR="${HOME}/toolkit"
    cd ${TOOLKIT_DIR}
    git clone ${PACKAGE_URL}
    cd CloudFlair
    # Use pip directly instead of the wrapper function
    /root/venv/bin/pip install -r requirements.txt
    chmod +x cloudflair.py
    ln -sf ${TOOLKIT_DIR}/CloudFlair/cloudflair.py /usr/local/bin/cloudflair
}

test() {
    command -v cloudflair
    return $?
} 