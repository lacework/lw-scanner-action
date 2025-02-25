# --------------------------------------------
# Stage 1: Alpine builder (for BusyBox static + su-exec)
# --------------------------------------------
FROM alpine:3.17 AS builder

# Install a statically-linked BusyBox and su-exec
RUN apk add --no-cache busybox-static su-exec

# Create a directory to hold our binaries
RUN mkdir /bundle

# Copy the busybox and su-exec binaries to /bundle
RUN cp /bin/busybox /bundle/busybox
RUN cp /sbin/su-exec /bundle/su-exec

# Copy and chmod your entrypoint script
COPY docker-entrypoint.sh /bundle/docker-entrypoint.sh
RUN chmod +x /bundle/docker-entrypoint.sh

# --------------------------------------------
# Stage 2: Lacework inline-scanner final image
# --------------------------------------------
FROM lacework/lacework-inline-scanner:0.27.0

# Copy the static BusyBox + su-exec + entrypoint from the builder
COPY --from=builder /bundle /bundle

# Use BusyBox for shell utilities
ENV PATH="/bundle:$PATH"

# Manually add a 'scanner' user in /etc/passwd & /etc/group
RUN echo "scanner:x:10001:10001:scanner user:/home/scanner:/bundle/busybox sh" >> /etc/passwd \
  && echo "scanner:x:10001:" >> /etc/group

# Copy the entrypoint script (already +x) to /
COPY --from=builder /bundle/docker-entrypoint.sh /docker-entrypoint.sh

# Must remain root for GitHub Actions Docker-based actions
ENTRYPOINT ["/docker-entrypoint.sh"]

