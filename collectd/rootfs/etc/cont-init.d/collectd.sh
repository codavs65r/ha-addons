#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
# ==============================================================================
# collectd setup
# ==============================================================================

HA_HOSTNAME=$(bashio::config 'hostname')
ENABLE_CPU_PLUGIN=$(bashio::config 'enable_cpu_plugin')
ENABLE_CPUFREQ_PLUGIN=$(bashio::config 'enable_cpufreq_plugin')
ENABLE_DF_PLUGIN=$(bashio::config 'enable_df_plugin')
ENABLE_DISK_PLUGIN=$(bashio::config 'enable_disk_plugin')
ENABLE_ENTROPY_PLUGIN=$(bashio::config 'enable_entropy_plugin')
ENABLE_INTERFACE_PLUGIN=$(bashio::config 'enable_interface_plugin')
ENABLE_IRQ_PLUGIN=$(bashio::config 'enable_irq_plugin')
ENABLE_LOAD_PLUGIN=$(bashio::config 'enable_load_plugin')
ENABLE_MEMORY_PLUGIN=$(bashio::config 'enable_memory_plugin')
ENABLE_PROCESSES_PLUGIN=$(bashio::config 'enable_processes_plugin')
ENABLE_SENSORS_PLUGIN=$(bashio::config 'enable_sensors_plugin')
ENABLE_SMART_PLUGIN=$(bashio::config 'enable_smart_plugin')
ENABLE_SWAP_PLUGIN=$(bashio::config 'enable_swap_plugin')
ENABLE_UPTIME_PLUGIN=$(bashio::config 'enable_uptime_plugin')
ENABLE_USERS_PLUGIN=$(bashio::config 'enable_users_plugin')
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

if [ "${ENABLE_CPU_PLUGIN}" == "false" ]
then
    sed -i \
    -e "s/^LoadPlugin cpu/#LoadPlugin cpu/g" \
    /etc/collectd/collectd.conf
fi

if [ "${ENABLE_CPUFREQ_PLUGIN}" == "false" ]
then
    sed -i \
    -e "s/^LoadPlugin cpufreq/#LoadPlugin cpufreq/g" \
    /etc/collectd/collectd.conf
fi

if [ "${ENABLE_DF_PLUGIN}" == "false" ]
then
    sed -i \
    -e "s/^LoadPlugin df/#LoadPlugin df/g" \
    /etc/collectd/collectd.conf
fi

if [ "${ENABLE_DISK_PLUGIN}" == "false" ]
then
    sed -i \
    -e "s/^LoadPlugin disk/#LoadPlugin disk/g" \
    /etc/collectd/collectd.conf
fi

if [ "${ENABLE_ENTROPY_PLUGIN}" == "false" ]
then
    sed -i \
    -e "s/^LoadPlugin entropy/#LoadPlugin entropy/g" \
    /etc/collectd/collectd.conf
fi

if [ "${ENABLE_INTERFACE_PLUGIN}" == "false" ]
then
    sed -i \
    -e "s/^LoadPlugin interface/#LoadPlugin interface/g" \
    /etc/collectd/collectd.conf
fi

if [ "${ENABLE_IRQ_PLUGIN}" == "false" ]
then
    sed -i \
    -e "s/^LoadPlugin irq/#LoadPlugin irq/g" \
    /etc/collectd/collectd.conf
fi

if [ "${ENABLE_LOAD_PLUGIN}" == "false" ]
then
    sed -i \
    -e "s/^LoadPlugin load/#LoadPlugin load/g" \
    /etc/collectd/collectd.conf
fi

if [ "${ENABLE_MEMORY_PLUGIN}" == "false" ]
then
    sed -i \
    -e "s/^LoadPlugin memory/#LoadPlugin memory/g" \
    /etc/collectd/collectd.conf
fi

if [ "${ENABLE_PROCESSES_PLUGIN}" == "false" ]
then
    sed -i \
    -e "s/^LoadPlugin processes/#LoadPlugin processes/g" \
    /etc/collectd/collectd.conf
fi

if [ "${ENABLE_SENSORS_PLUGIN}" == "false" ]
then
    sed -i \
    -e "s/^LoadPlugin sensors/#LoadPlugin sensors/g" \
    /etc/collectd/collectd.conf
fi

if [ "${ENABLE_SMART_PLUGIN}" == "false" ]
then
    sed -i \
    -e "s/^LoadPlugin smart/#LoadPlugin smart/g" \
    /etc/collectd/collectd.conf
fi

if [ "${ENABLE_SWAP_PLUGIN}" == "false" ]
then
    sed -i \
    -e "s/^LoadPlugin swap/#LoadPlugin swap/g" \
    /etc/collectd/collectd.conf
fi

if [ "${ENABLE_UPTIME_PLUGIN}" == "false" ]
then
    sed -i \
    -e "s/^LoadPlugin uptime/#LoadPlugin uptime/g" \
    /etc/collectd/collectd.conf
fi

if [ "${ENABLE_USERS_PLUGIN}" == "false" ]
then
    sed -i \
    -e "s/^LoadPlugin users/#LoadPlugin users/g" \
    /etc/collectd/collectd.conf
fi

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
