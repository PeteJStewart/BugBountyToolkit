#!/bin/bash

PACKAGE_NAME="recon-ng"
PACKAGE_TYPE="git"
PACKAGE_DEPS="python3"
PACKAGE_URL="https://github.com/lanmaster53/recon-ng.git"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    TOOLKIT_DIR="${HOME}/toolkit"
    cd ${TOOLKIT_DIR}
    git clone ${PACKAGE_URL}
    cd recon-ng
    /root/venv/bin/pip install -r REQUIREMENTS
    chmod +x recon-ng
    ln -sf ${TOOLKIT_DIR}/recon-ng/recon-ng /usr/local/bin/recon-ng
}

test() {
    command -v recon-ng
    return $?
} 