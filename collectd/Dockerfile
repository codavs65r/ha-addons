ARG BUILD_FROM
FROM $BUILD_FROM

# Setup base
RUN \
    set -x \
    && apk add --no-cache \
        collectd \
        collectd-write_prometheus \
        collectd-sensors \
        collectd-disk \
        collectd-smart

# Copy data
COPY rootfs /

EXPOSE 9103
