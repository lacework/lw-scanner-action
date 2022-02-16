FROM lacework/lacework-inline-scanner:latest
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
