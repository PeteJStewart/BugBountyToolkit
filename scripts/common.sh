#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

TOOLKIT_DIR="${HOME}/toolkit"
WORDLISTS_DIR="${TOOLKIT_DIR}/wordlists"

log() {
    echo -e "${GREEN}[*] $1${NC}"
}

setup_directories() {
    mkdir -p "${TOOLKIT_DIR}"
    mkdir -p "${WORDLISTS_DIR}"
}

install_apt_package() {
    apt-get install -y --no-install-recommends "$@"
}

install_pip_package() {
    /root/venv/bin/pip install "$@"
}

install_go_package() {
    go install -v "$@"
} 