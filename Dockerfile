FROM ghcr.io/timarenz/lw-scanner:v0.2.5
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]