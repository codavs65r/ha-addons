ARG BUILD_FROM
FROM $BUILD_FROM

EXPOSE 9103

# Setup base
RUN \
    set -x \
    && apk add --no-cache \
        collectd \
        collectd-write_prometheus \
        collectd-sensors \
        collectd-disk \
        collectd-smart \
        libmicrohttpd

# Copy data
COPY rootfs /

