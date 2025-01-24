#!/bin/bash

# Source common functions
source scripts/common.sh

log "Bug Bounty Toolkit Installer"
log "Setting Up Directories"

setup_directories

# Update package lists
apt-get update

# Install essentials first
source scripts/common.sh
source scripts/essentials.sh
install
test || echo "Failed to install essentials"

# Install additional packages
source scripts/packages/subfinder.sh
install
test || echo "Failed to install subfinder"

source scripts/packages/dnsenum.sh
install
test || echo "Failed to install dnsenum"

source scripts/packages/cloudflair.sh
install
test || echo "Failed to install cloudflair"


# SecLists
read -p "Do you want to download SecLists? y/n " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    log "Downloading SecLists"
    cd ${WORDLISTS_DIR}
    git clone --depth 1 https://github.com/danielmiessler/SecLists.git
fi

# Cleanup
log "Tidying up"
apt-get clean

log "Installation Complete!"
log "Your tools have been installed in: ${TOOLKIT_DIR}"
log "Your wordlists have been saved in: ${WORDLISTS_DIR}" 