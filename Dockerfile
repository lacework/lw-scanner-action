FROM lacework/lacework-inline-scanner:0.7.0
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
