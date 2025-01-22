FROM ubuntu:24.04

LABEL maintainer="Alexis Ahmed"

# Environment Variables
ENV HOME=/root
ENV DEBIAN_FRONTEND=noninteractive


# Working Directory
WORKDIR /root
RUN mkdir ${HOME}/toolkit && \
    mkdir ${HOME}/wordlists

# Install Essentials
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    tmux \
    gcc \
    iputils-ping\
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
    zsh\
    nano\
    && rm -rf /var/lib/apt/lists/*

# Install AWS CLI
# N snap install aws-cli --classic

# Install Dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    # sqlmap
    sqlmap \
    # dirb
    dirb \
    # dnsenum
    cpanminus \
    # wfuzz
    # python-pycurl \
    # knock
    # python-dnspython \
    # massdns
    libldns-dev \
    # wpcscan
    libcurl4-openssl-dev \
    libxml2 \
    libxml2-dev \
    libxslt1-dev \
    ruby-dev \
    libgmp-dev \
    zlib1g-dev \
    # masscan
    libpcap-dev \
    # theharvester
    Python3.12 \
    # joomscan
    libwww-perl \
    # hydra
    hydra \
    # dnsrecon
    dnsrecon \
    # zsh
    powerline\
    # zsh
    fonts-powerline\
    && rm -rf /var/lib/apt/lists/*

# tzdata
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

# configure python(s)
RUN python3 -m venv /root/venv && \
    echo 'export PATH=/root/venv/bin:$PATH' >> /root/.bashrc && \
    . /root/venv/bin/activate && \
    /root/venv/bin/pip install --upgrade pip setuptools

# dnsenum
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/fwaeytens/dnsenum.git && \
    cd dnsenum/ && \
    chmod +x dnsenum.pl && \
    ln -s ${HOME}/toolkit/dnsenum/dnsenum.pl /usr/bin/dnsenum && \
    cpanm String::Random && \
    cpanm Net::IP && \
    cpanm Net::DNS && \
    cpanm Net::Netmask && \
    cpanm XML::Writer

# Sublist3r
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/aboul3la/Sublist3r.git && \
    cd Sublist3r/ && \
    /root/venv/bin/pip install -r requirements.txt && \
    ln -s ${HOME}/toolkit/Sublist3r/sublist3r.py /usr/local/bin/sublist3r

# wfuzz
# RUN /root/venv/bin/pip install wfuzz

# seclists
RUN cd ${HOME}/wordlists && \
    git clone --depth 1 https://github.com/danielmiessler/SecLists.git 

# knock
# RUN cd ${HOME}/toolkit && \
#     git clone https://github.com/guelfoweb/knock.git && \
#     cd knock && \
#     chmod +x setup.py && \
#     apt-get update && apt-get install -y software-properties-common && \
#     add-apt-repository ppa:deadsnakes/ppa && \
#     /root/venv/bin/python setup.py install

# massdns
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/blechschmidt/massdns.git && \
    cd massdns/ && \
    make && \
    ln -sf ${HOME}/toolkit/massdns/bin/massdns /usr/local/bin/massdns

# wafw00f
# RUN cd ${HOME}/toolkit && \
#     git clone https://github.com/enablesecurity/wafw00f.git && \
#     cd wafw00f && \
#     chmod +x setup.py && \
#     /root/venv/bin/python setup.py install

# wpscan
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/wpscanteam/wpscan.git && \
    cd wpscan/ && \
    gem install bundler && bundle install --without test && \
    gem install wpscan

# commix 
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/commixproject/commix.git && \
    cd commix && \
    chmod +x commix.py && \
    ln -sf ${HOME}/toolkit/commix/commix.py /usr/local/bin/commix

# masscan
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/robertdavidgraham/masscan.git && \
    cd masscan && \
    make && \
    ln -sf ${HOME}/toolkit/masscan/bin/masscan /usr/local/bin/masscan

# altdns
# RUN cd ${HOME}/toolkit && \
#     git clone https://github.com/infosec-au/altdns.git && \
#     cd altdns && \
#     /root/venv/bin/pip install -r requirements.txt && \
#     chmod +x setup.py && \
#     /root/venv/bin/python setup.py install

# teh_s3_bucketeers
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/tomdev/teh_s3_bucketeers.git && \
    cd teh_s3_bucketeers && \
    chmod +x bucketeer.sh && \
    ln -sf ${HOME}/toolkit/teh_s3_bucketeers/bucketeer.sh /usr/local/bin/bucketeer

# Recon-ng
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/lanmaster53/recon-ng.git && \
    cd recon-ng && \
    /root/venv/bin/pip install -r REQUIREMENTS && \
    chmod +x recon-ng && \
    ln -sf ${HOME}/toolkit/recon-ng/recon-ng /usr/local/bin/recon-ng

# XSStrike
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/s0md3v/XSStrike.git && \
    cd XSStrike && \
    /root/venv/bin/pip install -r requirements.txt && \
    chmod +x xsstrike.py && \
    ln -sf ${HOME}/toolkit/XSStrike/xsstrike.py /usr/local/bin/xsstrike

# theHarvester
# RUN cd ${HOME}/toolkit && \
#     git clone https://github.com/AlexisAhmed/theHarvester.git && \
#     cd theHarvester && \
#     /root/venv/bin/pip install -r requirements.txt && \
#     chmod +x theHarvester.py && \
#     ln -sf ${HOME}/toolkit/theHarvester/theHarvester.py /usr/local/bin/theharvester

# CloudFlair
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/christophetd/CloudFlair.git && \
    cd CloudFlair && \
    /root/venv/bin/pip install -r requirements.txt && \
    chmod +x cloudflair.py && \
    ln -sf ${HOME}/toolkit/CloudFlair/cloudflair.py /usr/local/bin/cloudflair

# joomscan
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/rezasp/joomscan.git && \
    cd joomscan/ && \
    chmod +x joomscan.pl
COPY joomscan.sh /opt
RUN chmod +x /opt/joomscan.sh && \
    ln -sf /opt/joomscan.sh /usr/local/bin/joomscan

# go
RUN cd /opt && \
    wget https://golang.org/dl/go1.21.6.linux-amd64.tar.gz && \
    tar -xvf go1.21.6.linux-amd64.tar.gz && \
    rm -rf /opt/go1.21.6.linux-amd64.tar.gz && \
    mv go /usr/local
ENV GOROOT=/usr/local/go
ENV GOPATH=/root/go
ENV PATH=/root/venv/bin:${GOPATH}/bin:${GOROOT}/bin:${PATH}

# gobuster
RUN go install github.com/OJ/gobuster/v3@latest

# virtual-host-discovery
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/AlexisAhmed/virtual-host-discovery.git && \
    cd virtual-host-discovery && \
    chmod +x scan.rb && \
    ln -sf ${HOME}/toolkit/virtual-host-discovery/scan.rb /usr/local/bin/virtual-host-discovery

# bucket_finder
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/AlexisAhmed/bucket_finder.git && \
    cd bucket_finder && \
    chmod +x bucket_finder.rb && \
    ln -sf ${HOME}/toolkit/bucket_finder/bucket_finder.rb /usr/local/bin/bucket_finder

# dirsearch
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/AlexisAhmed/dirsearch.git && \
    cd dirsearch && \
    chmod +x dirsearch.py && \
    ln -sf ${HOME}/toolkit/dirsearch/dirsearch.py /usr/local/bin/dirsearch

# s3recon
RUN /root/venv/bin/pip install --upgrade setuptools && \
    /root/venv/bin/pip install pyyaml pymongo requests s3recon

# subfinder
RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# zsh
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh &&\
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc &&\
    chsh -s /bin/zsh && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1 && \
    echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"

# dotdotpwn
RUN cd ${HOME}/toolkit && \
    cpanm Net::FTP && \
    cpanm Time::HiRes && \
    cpanm HTTP::Lite && \
    cpanm Switch && \
    cpanm Socket && \
    cpanm IO::Socket && \
    cpanm Getopt::Std && \
    cpanm TFTP && \
    git clone https://github.com/AlexisAhmed/dotdotpwn.git && \
    cd dotdotpwn && \
    chmod +x dotdotpwn.pl && \
    ln -sf ${HOME}/toolkit/dotdotpwn/dotdotpwn.pl /usr/local/bin/dotdotpwn

# whatweb
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/urbanadventurer/WhatWeb.git && \
    cd WhatWeb && \
    chmod +x whatweb && \
    ln -sf ${HOME}/toolkit/WhatWeb/whatweb /usr/local/bin/whatweb

# fierce
RUN /root/venv/bin/pip install fierce

# amass
RUN go install -v github.com/owasp-amass/amass/v4/...@master

# S3Scanner
RUN go install -v github.com/sa7mon/s3scanner@latest

# droopsecan
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/droope/droopescan.git && \
    cd droopescan && \
    /root/venv/bin/pip install -r requirements.txt


# Compress wordlist
RUN cd ${HOME}/wordlists && \
    tar czf SecList.tar.gz ${HOME}/wordlists/SecLists/ && \
    rm -rf SecLists

# ZSH configuration
RUN export SHELL=/usr/bin/zsh && \
    cd ${HOME} && \
    rm .zshrc && \
    wget https://raw.githubusercontent.com/AlexisAhmed/BugBountyToolkit-ZSH/main/.zshrc

# ffuf
RUN go install github.com/ffuf/ffuf/v2@latest

# httprobe
RUN go install github.com/tomnomnom/httprobe@latest

# gitGraber
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/hisxo/gitGraber.git && \
    cd gitGraber && \
    ln -sf ${HOME}/toolkit/gitGraber/gitGraber.py /usr/local/bin/gitGraber


# waybackurls
RUN go install github.com/tomnomnom/waybackurls@latest

# Katoolin
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/LionSec/katoolin.git && \
    cd katoolin && \
    chmod +x katoolin.py


# Clean Go Cache
RUN go clean -cache && \
    go clean -testcache && \
    go clean -modcache
