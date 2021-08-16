FROM alpine:3.14.1
RUN apk update && apk add --no-cache docker-cli jq
RUN wget -O /usr/local/bin/lw-scanner https://github.com/lacework/lacework-vulnerability-scanner/releases/download/v0.1.3/lw-scanner-linux-arm64 && chmod +x /usr/local/bin/lw-scanner
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]