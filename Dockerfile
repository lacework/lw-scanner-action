FROM lacework/lacework-inline-scanner:0.10.1
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
