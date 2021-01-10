FROM alpine:3.12

ARG DDCLIENT_VER=3.9.1

RUN apk add --no-cache --virtual=build-deps \
        wget \
        make && \
    apk add --no-cache \
        perl \
        perl-io-socket-ssl \
        perl-io-socket-inet6 \
        perl-json && \
    wget -qO- https://cpanmin.us | perl - App::cpanminus && \
    cpanm Data::Validate::IP && \
    mkdir -p /tmp/ddclient && \
    wget -qO- https://github.com/ddclient/ddclient/archive/v$DDCLIENT_VER.tar.gz | tar xz --strip-components=1 -C /tmp/ddclient && \
    install -Dm755 /tmp/ddclient/ddclient /usr/bin && \
    rm -rf /tmp/ddclient && \
    apk del --purge \
        build-deps

COPY docker-entrypoint.sh /

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "/usr/bin/ddclient", "-foreground" ]