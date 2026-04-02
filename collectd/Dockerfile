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
        mosquitto-clients

# Copy data
COPY rootfs /

# Shared directory
ADD /root/config /opt/config
