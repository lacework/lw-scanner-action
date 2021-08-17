FROM ghcr.io/timarenz/lw-scanner:v0.1.3
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]