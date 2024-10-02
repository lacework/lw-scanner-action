FROM lacework/lacework-inline-scanner:0.27.0
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
