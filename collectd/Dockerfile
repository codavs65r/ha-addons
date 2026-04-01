ARG BUILD_FROM
FROM $BUILD_FROM

# Setup base
RUN \
    set -x \
    && apk add --no-cache \
        collectd \
        collectd-sensors \
        collectd-disk \
        collectd-smart \
        collectd-mqtt \
        mosquitos-clients

# Copy data
COPY rootfs /

