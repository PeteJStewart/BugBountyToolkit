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
source scripts/packages/masscan.sh
install
test || echo "Failed to install masscan"

source scripts/packages/bucket_finder.sh
install
test || echo "Failed to install bucket_finder"

source scripts/packages/dirb.sh
install
test || echo "Failed to install dirb"

source scripts/packages/subfinder.sh
install
test || echo "Failed to install subfinder"

source scripts/packages/sqlmap.sh
install
test || echo "Failed to install sqlmap"

source scripts/packages/fierce.sh
install
test || echo "Failed to install fierce"

source scripts/packages/httprobe.sh
install
test || echo "Failed to install httprobe"

source scripts/packages/ffuf.sh
install
test || echo "Failed to install ffuf"

source scripts/packages/subjack.sh
install
test || echo "Failed to install subjack"

source scripts/packages/hydra.sh
install
test || echo "Failed to install hydra"

source scripts/packages/s3recon.sh
install
test || echo "Failed to install s3recon"

source scripts/packages/virtual-host-discovery.sh
install
test || echo "Failed to install virtual-host-discovery"

source scripts/packages/massdns.sh
install
test || echo "Failed to install massdns"

source scripts/packages/gitgraber.sh
install
test || echo "Failed to install gitgraber"

source scripts/packages/wfuzz.sh
install
test || echo "Failed to install wfuzz"

source scripts/packages/amass.sh
install
test || echo "Failed to install amass"

source scripts/packages/gobuster.sh
install
test || echo "Failed to install gobuster"

source scripts/packages/s3scanner.sh
install
test || echo "Failed to install s3scanner"

source scripts/packages/dnsenum.sh
install
test || echo "Failed to install dnsenum"

source scripts/packages/wpscan.sh
install
test || echo "Failed to install wpscan"

source scripts/packages/cloudflair.sh
install
test || echo "Failed to install cloudflair"

source scripts/packages/commix.sh
install
test || echo "Failed to install commix"

source scripts/packages/waybackurls.sh
install
test || echo "Failed to install waybackurls"

source scripts/packages/theharvester.sh
install
test || echo "Failed to install theharvester"

source scripts/packages/dirsearch.sh
install
test || echo "Failed to install dirsearch"

source scripts/packages/whatweb.sh
install
test || echo "Failed to install whatweb"

source scripts/packages/dotdotpwn.sh
install
test || echo "Failed to install dotdotpwn"

source scripts/packages/jsluice.sh
install
test || echo "Failed to install jsluice"

source scripts/packages/droopescan.sh
install
test || echo "Failed to install droopescan"

source scripts/packages/teh-s3-bucketeers.sh
install
test || echo "Failed to install teh-s3-bucketeers"

source scripts/packages/knockpy.sh
install
test || echo "Failed to install knockpy"

source scripts/packages/joomscan.sh
install
test || echo "Failed to install joomscan"

source scripts/packages/dnsrecon.sh
install
test || echo "Failed to install dnsrecon"

source scripts/packages/jwt_tool.sh
install
test || echo "Failed to install jwt_tool"

source scripts/packages/sublist3r.sh
install
test || echo "Failed to install sublist3r"

source scripts/packages/xsstrike.sh
install
test || echo "Failed to install xsstrike"

source scripts/packages/wafw00f.sh
install
test || echo "Failed to install wafw00f"

source scripts/packages/recon-ng.sh
install
test || echo "Failed to install recon-ng"

source scripts/packages/subover.sh
install
test || echo "Failed to install subover"


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