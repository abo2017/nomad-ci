FROM scratch

COPY apt.conf /etc/apt/
COPY docker.env /etc/

ADD name-service /name-service

CMD ["/name-service"]
