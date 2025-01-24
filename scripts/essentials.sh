#!/bin/bash

PACKAGE_NAME="essentials"
PACKAGE_TYPE="apt"
PACKAGE_DEPS=""

install() {
    log "Installing ${PACKAGE_NAME}"
    install_apt_package \
        build-essential \
        tmux \
        gcc \
        iputils-ping \
        git \
        vim \
        wget \
        tzdata \
        curl \
        make \
        nmap \
        whois \
        python3 \
        python3-pip \
        python3-dev \
        python3-venv \
        snapd \
        perl \
        nikto \
        dnsutils \
        net-tools \
        zsh \
        nano
}

test() {
    command -v gcc && \
    command -v git && \
    command -v python3
    return $?
} 