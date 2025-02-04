#!/bin/bash

PACKAGE_NAME="bucket_finder"
PACKAGE_TYPE="git"
PACKAGE_DEPS=""
PACKAGE_URL="https://github.com/AlexisAhmed/bucket_finder.git"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    TOOLKIT_DIR="${HOME}/toolkit"
    cd ${TOOLKIT_DIR}
    git clone ${PACKAGE_URL}
    cd bucket_finder
    chmod +x bucket_finder.rb
    ln -sf ${TOOLKIT_DIR}/bucket_finder/bucket_finder.rb /usr/local/bin/bucket_finder
}

test() {
    command -v bucket_finder
    return $?
} 