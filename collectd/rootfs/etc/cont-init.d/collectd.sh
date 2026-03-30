#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
# ==============================================================================
# collectd setup
# ==============================================================================

HA_HOSTNAME=$(bashio::config 'hostname')
ENABLE_GRAPHITE_PLUGIN=$(bashio::config 'enable_graphite_plugin')
ENABLE_WRITE_PROMETHEUS_PLUGIN=$(bashio::config 'enable_write_prometheus_plugin')
GRAPHITE_HOST=$(bashio::config 'graphite_host')
GRAPHITE_PREFIX=$(bashio::config 'graphite_prefix')
GRAPHITE_EXPORTER_HOST=$(bashio::config 'graphite_exporter_host')
GRAPHITE_EXPORTER_PORT=$(bashio::config 'graphite_exporter_port')

sed -i \
    -e "s/{{hostname}}/${HA_HOSTNAME}/g" \
    -e "s/{{graphite_host}}/${GRAPHITE_HOST}/g" \
    -e "s/{{graphite_prefix}}/${GRAPHITE_PREFIX}/g" \
    -e "s/{{graphite_exporter_host}}/${GRAPHITE_EXPORTER_HOST}/g" \
    -e "s/{{graphite_exporter_port}}/${GRAPHITE_EXPORTER_PORT}/g" \
    /etc/collectd/collectd.conf

if [ "${ENABLE_GRAPHITE_PLUGIN}" = "true" ]; then
    bashio::log.info "Enabling Graphite plugin"
    sed -i "s/#LoadPlugin graphite/LoadPlugin graphite/g" /etc/collectd/collectd.conf
fi

if [ "${ENABLE_WRITE_PROMETHEUS_PLUGIN}" = "true" ]; then
    bashio::log.info "Enabling Prometheus plugin"
    sed -i "s/#LoadPlugin write_prometheus/LoadPlugin write_prometheus/g" /etc/collectd/collectd.conf
fi

bashio::log.info "Service setup applied"
