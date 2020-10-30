FROM ubuntu

RUN apt-get update && \
	apt-get -y install \
        bmon \
        curl \
        dnsutils \
        iftop \
        iperf \
        iputils-ping \
        lynx \
        mtr-tiny \
        net-tools \
        netcat \
        nmap \
        openssh-client \
        strace \
        sysstat \
        tcpdump \
        tcptraceroute \
        traceroute \
        telnet \
        vim \
        wget \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/bin/bash"]
