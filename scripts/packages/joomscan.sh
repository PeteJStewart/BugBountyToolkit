#!/bin/bash

PACKAGE_NAME="joomscan"
PACKAGE_TYPE="git"
PACKAGE_DEPS="libwww-perl"
PACKAGE_URL="https://github.com/rezasp/joomscan.git"

log() {
    echo -e "\033[0;32m[*] $1\033[0m"
}

install() {
    log "Installing ${PACKAGE_NAME}"
    TOOLKIT_DIR="${HOME}/toolkit"
    cd ${TOOLKIT_DIR}
    git clone ${PACKAGE_URL}
    cd joomscan/
    chmod +x joomscan.pl
    # Create wrapper script
    echo '#!/bin/bash' > /usr/local/bin/joomscan
    echo "perl ${TOOLKIT_DIR}/joomscan/joomscan.pl \"\$@\"" >> /usr/local/bin/joomscan
    chmod +x /usr/local/bin/joomscan
}

test() {
    command -v joomscan
    return $?
} 