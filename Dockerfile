FROM ghcr.io/timarenz/lw-scanner:v0.2.1
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]