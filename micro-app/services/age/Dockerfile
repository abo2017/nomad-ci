FROM scratch

COPY apt.conf /etc/apt/
COPY docker.env /etc/

ADD age-service /age-service

CMD ["/age-service"]
