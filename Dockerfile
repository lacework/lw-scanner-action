FROM lacework/lacework-inline-scanner:0.23.2
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
