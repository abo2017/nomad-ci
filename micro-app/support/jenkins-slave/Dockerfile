FROM golang:1.6

COPY apt.conf /etc/apt/
COPY docker.env /etc/
ADD https://get.docker.com/builds/Linux/x86_64/docker-1.10.3 /usr/local/bin/docker

RUN apt-get update && \
	. /etc/docker.env && \
    curl -sL --proxy http://192.168.22.1:3129 https://deb.nodesource.com/setup_6.x | bash - && \
	HTTPS_PROXY=http://192.168.22.1:3129 && \
	https_proxy=http://192.168.22.1:3129 && \
    apt-get install -y jq nodejs git openjdk-7-jre-headless && \
    npm install -g chai wdio-junit-reporter wdio-mocha-framework webdriverio && \
    chmod +x /usr/local/bin/docker
