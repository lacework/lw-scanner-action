FROM lacework/lacework-inline-scanner:0.14.2
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
