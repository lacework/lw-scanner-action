FROM lacework/lacework-inline-scanner:0.27.0

# install su-exec/gosu
# alpine-based
RUN apk add --no-cache su-exec

# debian/ubuntu-based
RUN apt-get update && apt-get install -y gosu && rm -rf /var/lib/apt/lists/*

# create a non-root user but do not switch to it via USER
# uses an example user/group UID/GUID
RUN addgroup --system scanner && adduser --system --ingroup scanner --no-create-home scanner

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
