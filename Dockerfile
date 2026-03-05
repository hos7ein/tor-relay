FROM alpine:3.23
LABEL maintainer="hos7ein <hossein.a97@gmail.com>"

ENV RELAY_NICKNAME=ChangeMe
ENV RELAY_TYPE=middle
ENV RELAY_BANDWIDTH_RATE="100 KBytes"
ENV RELAY_BANDWIDTH_BURST="200 KBytes"
ENV RELAY_ORPORT=9001
ENV RELAY_DIRPORT=9030
ENV RELAY_CTRLPORT=9051
ENV RELAY_ACCOUNTING_MAX="1 GBytes"
ENV RELAY_ACCOUNTING_START="day 00:00"

# add group/user tor with ID
# install tor, nyx, bash
RUN addgroup -g 1000 -S tor && \
    adduser -u 1000 -S tor -G tor && \
    apk update && \
    apk add --no-cache tor nyx bash && \
    rm -rf /var/cache/apk/*

VOLUME ["/var/lib/tor"]

# copy in our torrc files
COPY torrc* /etc/tor/

# copy the run script
COPY run.sh /run.sh

RUN chmod ugo+rx /run.sh && \
    chown -R tor /etc/tor && \
    chown -R tor /var/lib/tor

USER tor

EXPOSE 9001

ENTRYPOINT [ "/run.sh" ]
