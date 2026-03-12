#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
# ==============================================================================
# collectd setup
# ==============================================================================

HA_HOSTNAME=$(bashio::config 'hostname')
GRAPHITE_HOST=$(bashio::config 'graphite_host')
GRAPHITE_PREFIX=$(bashio::config 'graphite_prefix')
PROMETHEUS_PORT=$(bashio::config 'prometheus_port')

sed -i \
    -e "s/{{hostname}}/${HA_HOSTNAME}/g" \
    -e "s/{{graphite_host}}/${GRAPHITE_HOST}/g" \
    -e "s/{{graphite_prefix}}/${GRAPHITE_PREFIX}/g" \
    -e "s/{{prometheus_port}}/${PROMETHEUS_PORT}/g" \
    /etc/collectd/collectd.conf
