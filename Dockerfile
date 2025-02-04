FROM ubuntu:latest

LABEL maintainer="Pete Stewart <pete@tinkr.co.uk>"

# Environment Variables
ENV HOME=/root
ENV DEBIAN_FRONTEND=noninteractive

# Working Directory
WORKDIR /root
RUN mkdir ${HOME}/toolkit && \
    mkdir ${HOME}/wordlists

# Copy and install essentials first
COPY scripts/essentials.sh /opt/
RUN /bin/bash -c 'source /opt/essentials.sh && \
    install && \
    test || echo "Failed to install essentials"'

# Go installation and setup
RUN cd /opt && \
    wget https://golang.org/dl/go1.21.6.linux-amd64.tar.gz && \
    tar -xvf go1.21.6.linux-amd64.tar.gz && \
    rm -rf /opt/go1.21.6.linux-amd64.tar.gz && \
    mv go /usr/local
ENV GOROOT=/usr/local/go
ENV GOPATH=/root/go

# Python virtual environment setup (moved after essentials installation)
RUN python3 -m venv /root/venv && \
    echo 'export PATH=/root/venv/bin:$PATH' >> /root/.bashrc && \
    . /root/venv/bin/activate && \
    /root/venv/bin/pip install --upgrade pip setuptools

# Update PATH to include all tools
ENV PATH=/root/venv/bin:${GOPATH}/bin:${GOROOT}/bin:${PATH}

# Install packages
# Package: masscan
# URL: https://github.com/robertdavidgraham/masscan.git
COPY scripts/packages/masscan.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/masscan.sh && install && test || echo "Failed to install masscan"'

# Package: bucket_finder
# URL: https://github.com/AlexisAhmed/bucket_finder.git
COPY scripts/packages/bucket_finder.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/bucket_finder.sh && install && test || echo "Failed to install bucket_finder"'

# Package: dirb
# URL: No repository URL specified
COPY scripts/packages/dirb.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/dirb.sh && install && test || echo "Failed to install dirb"'

# Package: subfinder
# URL: github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
COPY scripts/packages/subfinder.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/subfinder.sh && install && test || echo "Failed to install subfinder"'

# Package: sqlmap
# URL: https://github.com/sqlmapproject/sqlmap.git
COPY scripts/packages/sqlmap.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/sqlmap.sh && install && test || echo "Failed to install sqlmap"'

# Package: fierce
# URL: fierce
COPY scripts/packages/fierce.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/fierce.sh && install && test || echo "Failed to install fierce"'

# Package: httprobe
# URL: github.com/tomnomnom/httprobe@latest
COPY scripts/packages/httprobe.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/httprobe.sh && install && test || echo "Failed to install httprobe"'

# Package: ffuf
# URL: github.com/ffuf/ffuf@latest
COPY scripts/packages/ffuf.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/ffuf.sh && install && test || echo "Failed to install ffuf"'

# Package: subjack
# URL: github.com/haccer/subjack@latest
COPY scripts/packages/subjack.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/subjack.sh && install && test || echo "Failed to install subjack"'

# Package: hydra
# URL: No repository URL specified
COPY scripts/packages/hydra.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/hydra.sh && install && test || echo "Failed to install hydra"'

# Package: s3recon
# URL: s3recon
COPY scripts/packages/s3recon.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/s3recon.sh && install && test || echo "Failed to install s3recon"'

# Package: virtual-host-discovery
# URL: https://github.com/AlexisAhmed/virtual-host-discovery.git
COPY scripts/packages/virtual-host-discovery.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/virtual-host-discovery.sh && install && test || echo "Failed to install virtual-host-discovery"'

# Package: massdns
# URL: https://github.com/blechschmidt/massdns.git
COPY scripts/packages/massdns.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/massdns.sh && install && test || echo "Failed to install massdns"'

# Package: gitgraber
# URL: https://github.com/hisxo/gitGraber.git
COPY scripts/packages/gitgraber.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/gitgraber.sh && install && test || echo "Failed to install gitgraber"'

# Package: wfuzz
# URL: wfuzz
COPY scripts/packages/wfuzz.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/wfuzz.sh && install && test || echo "Failed to install wfuzz"'

# Package: amass
# URL: github.com/owasp-amass/amass/v4/...@master
COPY scripts/packages/amass.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/amass.sh && install && test || echo "Failed to install amass"'

# Package: gobuster
# URL: github.com/OJ/gobuster/v3@latest
COPY scripts/packages/gobuster.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/gobuster.sh && install && test || echo "Failed to install gobuster"'

# Package: s3scanner
# URL: github.com/sa7mon/s3scanner@latest
COPY scripts/packages/s3scanner.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/s3scanner.sh && install && test || echo "Failed to install s3scanner"'

# Package: dnsenum
# URL: https://github.com/fwaeytens/dnsenum.git
COPY scripts/packages/dnsenum.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/dnsenum.sh && install && test || echo "Failed to install dnsenum"'

# Package: wpscan
# URL: No repository URL specified
COPY scripts/packages/wpscan.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/wpscan.sh && install && test || echo "Failed to install wpscan"'

# Package: cloudflair
# URL: https://github.com/christophetd/CloudFlair.git
COPY scripts/packages/cloudflair.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/cloudflair.sh && install && test || echo "Failed to install cloudflair"'

# Package: commix
# URL: https://github.com/commixproject/commix.git
COPY scripts/packages/commix.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/commix.sh && install && test || echo "Failed to install commix"'

# Package: waybackurls
# URL: github.com/tomnomnom/waybackurls@latest
COPY scripts/packages/waybackurls.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/waybackurls.sh && install && test || echo "Failed to install waybackurls"'

# Package: theharvester
# URL: https://github.com/AlexisAhmed/theHarvester.git
COPY scripts/packages/theharvester.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/theharvester.sh && install && test || echo "Failed to install theharvester"'

# Package: dirsearch
# URL: https://github.com/maurosoria/dirsearch.git
COPY scripts/packages/dirsearch.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/dirsearch.sh && install && test || echo "Failed to install dirsearch"'

# Package: whatweb
# URL: https://github.com/urbanadventurer/WhatWeb.git
COPY scripts/packages/whatweb.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/whatweb.sh && install && test || echo "Failed to install whatweb"'

# Package: dotdotpwn
# URL: https://github.com/wireghoul/dotdotpwn.git
COPY scripts/packages/dotdotpwn.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/dotdotpwn.sh && install && test || echo "Failed to install dotdotpwn"'

# Package: jsluice
# URL: github.com/BishopFox/jsluice/cmd/jsluice@latest
COPY scripts/packages/jsluice.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/jsluice.sh && install && test || echo "Failed to install jsluice"'

# Package: droopescan
# URL: droopescan
COPY scripts/packages/droopescan.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/droopescan.sh && install && test || echo "Failed to install droopescan"'

# Package: teh-s3-bucketeers
# URL: https://github.com/tomdev/teh_s3_bucketeers.git
COPY scripts/packages/teh-s3-bucketeers.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/teh-s3-bucketeers.sh && install && test || echo "Failed to install teh-s3-bucketeers"'

# Package: knockpy
# URL: https://github.com/guelfoweb/knock.git
COPY scripts/packages/knockpy.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/knockpy.sh && install && test || echo "Failed to install knockpy"'

# Package: joomscan
# URL: https://github.com/rezasp/joomscan.git
COPY scripts/packages/joomscan.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/joomscan.sh && install && test || echo "Failed to install joomscan"'

# Package: dnsrecon
# URL: No repository URL specified
COPY scripts/packages/dnsrecon.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/dnsrecon.sh && install && test || echo "Failed to install dnsrecon"'

# Package: jwt_tool
# URL: https://github.com/ticarpi/jwt_tool.git
COPY scripts/packages/jwt_tool.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/jwt_tool.sh && install && test || echo "Failed to install jwt_tool"'

# Package: sublist3r
# URL: https://github.com/aboul3la/Sublist3r.git
COPY scripts/packages/sublist3r.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/sublist3r.sh && install && test || echo "Failed to install sublist3r"'

# Package: xsstrike
# URL: https://github.com/s0md3v/XSStrike.git
COPY scripts/packages/xsstrike.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/xsstrike.sh && install && test || echo "Failed to install xsstrike"'

# Package: wafw00f
# URL: wafw00f
COPY scripts/packages/wafw00f.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/wafw00f.sh && install && test || echo "Failed to install wafw00f"'

# Package: recon-ng
# URL: https://github.com/lanmaster53/recon-ng.git
COPY scripts/packages/recon-ng.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/recon-ng.sh && install && test || echo "Failed to install recon-ng"'

# Package: subover
# URL: github.com/Ice3man543/SubOver@latest
COPY scripts/packages/subover.sh /opt/packages/
RUN /bin/bash -c 'source /opt/packages/subover.sh && install && test || echo "Failed to install subover"'


# Clone SecLists
RUN cd ${HOME}/wordlists && \
    git clone --depth 1 https://github.com/danielmiessler/SecLists.git

# Download Assetnote Wordlists
RUN cd ${HOME}/wordlists && \
    wget -r --no-parent -R "index.html*" https://wordlists-cdn.assetnote.io/data/ -nH -e robots=off

# Clean Go Cache
RUN go clean -cache && \
    go clean -testcache && \
    go clean -modcache 