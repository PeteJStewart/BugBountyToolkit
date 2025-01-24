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
COPY scripts/common.sh /opt/
COPY scripts/essentials.sh /opt/
RUN source /opt/common.sh && \
    source /opt/essentials.sh && \
    install && \
    test || echo "Failed to install essentials"

# Python virtual environment setup
RUN python3 -m venv /root/venv && \
    echo 'export PATH=/root/venv/bin:$PATH' >> /root/.bashrc && \
    . /root/venv/bin/activate && \
    /root/venv/bin/pip install --upgrade pip setuptools

# Go installation and setup
RUN cd /opt && \
    wget https://golang.org/dl/go1.21.6.linux-amd64.tar.gz && \
    tar -xvf go1.21.6.linux-amd64.tar.gz && \
    rm -rf /opt/go1.21.6.linux-amd64.tar.gz && \
    mv go /usr/local
ENV GOROOT=/usr/local/go
ENV GOPATH=/root/go
ENV PATH=/root/venv/bin:${GOPATH}/bin:${GOROOT}/bin:${PATH}

# Install packages
COPY scripts/common.sh /opt/
COPY scripts/essentials.sh /opt/
COPY scripts/packages/subfinder.sh /opt/packages/
COPY scripts/packages/dnsenum.sh /opt/packages/
COPY scripts/packages/cloudflair.sh /opt/packages/
RUN source /opt/common.sh && \
    source /opt/essentials.sh && \
    install && \
    test || echo "Failed to install essentials" && \
    source /opt/packages/subfinder.sh && \
    install && \
    test || echo "Failed to install subfinder" && \
    source /opt/packages/dnsenum.sh && \
    install && \
    test || echo "Failed to install dnsenum" && \
    source /opt/packages/cloudflair.sh && \
    install && \
    test || echo "Failed to install cloudflair"

# Compress wordlist
RUN cd ${HOME}/wordlists && \
    tar czf SecList.tar.gz ${HOME}/wordlists/SecLists/ && \
    rm -rf SecLists

# Clean Go Cache
RUN go clean -cache && \
    go clean -testcache && \
    go clean -modcache 