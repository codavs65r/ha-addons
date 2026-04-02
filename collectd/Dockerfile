ARG BUILD_FROM
FROM $BUILD_FROM

# Setup base
RUN --mount=type=bind,source=/homeassistant,target=/opt/config \
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
