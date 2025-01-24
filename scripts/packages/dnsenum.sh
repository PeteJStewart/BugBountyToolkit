#!/bin/bash

PACKAGE_NAME="dnsenum"
PACKAGE_TYPE="git"
PACKAGE_DEPS="cpanminus"
PACKAGE_URL="https://github.com/fwaeytens/dnsenum.git"

install() {
    log "Installing ${PACKAGE_NAME}"
    cd ${HOME}/toolkit
    git clone ${PACKAGE_URL}
    cd dnsenum/
    chmod +x dnsenum.pl
    ln -s ${HOME}/toolkit/dnsenum/dnsenum.pl /usr/bin/dnsenum
    cpanm String::Random
    cpanm Net::IP
    cpanm Net::DNS
    cpanm Net::Netmask
    cpanm XML::Writer
}

test() {
    command -v dnsenum
    return $?
} 