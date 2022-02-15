FROM ipcrm/inline-scanner-temp:latest
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
