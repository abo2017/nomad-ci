FROM jenkins:1.642.2

COPY docker.env /etc/
COPY apt.conf /etc/apt/ 

COPY home /usr/share/jenkins/ref/

RUN . /etc/docker.env && /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt

USER root

RUN apt-get update && apt-get install jq

USER jenkins
