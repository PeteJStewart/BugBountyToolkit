#!/bin/bash

PACKAGE_NAME="dotdotpwn"
PACKAGE_TYPE="git"
PACKAGE_DEPS="perl"
PACKAGE_URL="https://github.com/wireghoul/dotdotpwn.git"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    TOOLKIT_DIR="${HOME}/toolkit"
    cd ${TOOLKIT_DIR}
    git clone ${PACKAGE_URL}
    cd dotdotpwn
    chmod +x dotdotpwn.pl
    ln -sf ${TOOLKIT_DIR}/dotdotpwn/dotdotpwn.pl /usr/local/bin/dotdotpwn
    cpanm Switch
    cpanm TFTP
}

test() {
    command -v dotdotpwn
    return $?
} 