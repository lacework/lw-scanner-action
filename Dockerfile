FROM lacework/lacework-inline-scanner:0.2.9
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
