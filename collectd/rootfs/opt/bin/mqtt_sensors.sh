#!/usr/bin/with-contenv bashio
# vim: ft=bash
# shellcheck shell=bash

HA_HOSTNAME=$(bashio::config 'hostname')
MQTT_USER=$(bashio::config 'mqtt_user')
MQTT_PASSWORD=$(bashio::config 'mqtt_password')

bashio::log.info "Getting metrics from MQTT topic: collectd/${HA_HOSTNAME}/#"
mosquitto_sub -h core-mosquitto -p 1883 -u "${MQTT_USER}" -P "${MQTT_PASSWORD}" -t collectd/"${HA_HOSTNAME}"/# -v -W 15 | awk '{print $1}' | sort | uniq > /var/tmp/collectd.mqtt.txt

metrics=$(cat /var/tmp/collectd.mqtt.txt)

for metric in $metrics
do
    node_name=$(echo "$metric" | cut -d'/' -f3)
    metric_name=$(echo "$metric" | cut -d'/' -f3)
    if [ "$node_name" == "cpu-"* ]
    then      
        bashio::log.info "Processing metric: $node_name/$metric_name"
        mosquitto_pub -r -h core-mosquitto -p 1883 -u "${MQTT_USER}" -P "${MQTT_PASSWORD}" -t "homeassistant/binary_sensor/garden/config" -m '{"name": null, "state_topic": "$metric", "unique_id": "$node_name", "value_template": "{{ (value.split(\':\')[1].split(\'\0\')[0] | float(0)) | round(1) }}", "state_class": "measurement", "icon": "mdi:cpu-64-bit", "device": {"identifiers": "collectd"], "name": "Collectd", "model": "$HA_HOSTNAME"}'
    fi
done
