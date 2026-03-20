#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
# ==============================================================================
# collectd setup
# ==============================================================================

HA_HOSTNAME=$(bashio::config 'hostname')
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

bashio::log.info "Service setup applied"
