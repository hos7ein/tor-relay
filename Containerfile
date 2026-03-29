# Base
FROM alpine:3.23

LABEL maintainer="hos7ein <hossein.a97@gmail.com>"

# Default environment variables
ENV RELAY_NICKNAME="ChangeMe" \
    RELAY_TYPE="middle" \
    RELAY_BANDWIDTH_RATE="100 KBytes" \
    RELAY_BANDWIDTH_BURST="200 KBytes" \
    RELAY_ORPORT=9001 \
    RELAY_DIRPORT=9030 \
    RELAY_CTRLPORT=9051 \
    RELAY_ACCOUNTING_MAX="1 GBytes" \
    RELAY_ACCOUNTING_START="day 00:00"

# Install packages
RUN apk update && \
    apk add --no-cache tor nyx shadow su-exec bash && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /var/lib/tor

# Prepare directory
VOLUME ["/var/lib/tor"]

COPY torrc* /etc/tor/
COPY run.sh /run.sh

RUN chmod +x /run.sh

EXPOSE 9001

ENTRYPOINT ["/run.sh"]
