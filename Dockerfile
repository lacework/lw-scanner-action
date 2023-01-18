FROM lacework/lacework-inline-scanner:0.14.1
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
