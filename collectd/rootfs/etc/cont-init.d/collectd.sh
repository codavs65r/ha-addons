#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
# ==============================================================================
# collectd setup
# ==============================================================================

HA_HOSTNAME=$(bashio::config 'hostname')
ENABLE_MQTT_PLUGIN=$(bashio::config 'enable_mqtt_plugin')
MQTT_USER=$(bashio::config 'mqtt_user')
MQTT_PASSWORD=$(bashio::config 'mqtt_password')
ENABLE_WRITE_GRAPHITE_PLUGIN=$(bashio::config 'enable_write_graphite_plugin')
GRAPHITE_HOST=$(bashio::config 'graphite_host')
GRAPHITE_PREFIX=$(bashio::config 'graphite_prefix')
GRAPHITE_EXPORTER_HOST=$(bashio::config 'graphite_exporter_host')
GRAPHITE_EXPORTER_PORT=$(bashio::config 'graphite_exporter_port')
ENABLE_WRITE_PROMETHEUS_PLUGIN=$(bashio::config 'enable_write_prometheus_plugin')
PROMETHEUS_PORT=$(bashio::config 'prometheus_port')

sed -i \
    -e "s/{{hostname}}/${HA_HOSTNAME}/g" \
    -e "s/{{mqtt_user}}/${MQTT_USER}/g" \
    -e "s/{{mqtt_password}}/${MQTT_PASSWORD}/g" \
    -e "s/{{graphite_host}}/${GRAPHITE_HOST}/g" \
    -e "s/{{graphite_prefix}}/${GRAPHITE_PREFIX}/g" \
    -e "s/{{graphite_exporter_host}}/${GRAPHITE_EXPORTER_HOST}/g" \
    -e "s/{{graphite_exporter_port}}/${GRAPHITE_EXPORTER_PORT}/g" \
    -e "s/{{prometheus_port}}/${PROMETHEUS_PORT}/g" \
    /etc/collectd/collectd.conf

if [ "${ENABLE_MQTT_PLUGIN}" == "true" ]
then
    sed -i \
    -e "s/^#LoadPlugin mqtt/LoadPlugin mqtt/g" \
    /etc/collectd/collectd.conf
fi

if [ "${ENABLE_WRITE_GRAPHITE_PLUGIN}" == "true" ]
then
    sed -i \
    -e "s/^#LoadPlugin write_graphite/LoadPlugin write_graphite/g" \
    /etc/collectd/collectd.conf
fi

if [ "${ENABLE_WRITE_PROMETHEUS_PLUGIN}" == "true" ]
then
    sed -i -e \
    "s/^#LoadPlugin write_prometheus/LoadPlugin write_prometheus/g" \
    /etc/collectd/collectd.conf
fi

bashio::log.info "Service setup applied"
cat /opt/config/collectd.yaml
