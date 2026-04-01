#!/usr/bin/with-contenv bashio
# vim: ft=bash
# shellcheck shell=bash

if [ -f /var/tmp/collectd.mqtt.txt ]
then
  #bashio::log.info "MQTT metrics already created"
  exit 0
fi

sleep 2

HA_HOSTNAME=$(bashio::config 'hostname')
MQTT_USER=$(bashio::config 'mqtt_user')
MQTT_PASSWORD=$(bashio::config 'mqtt_password')

bashio::log.info "Getting metrics from MQTT topic: collectd/${HA_HOSTNAME}/#"
mosquitto_sub -h core-mosquitto -p 1883 -u ${MQTT_USER} -P ${MQTT_PASSWORD} -t collectd/${HA_HOSTNAME}/# -v -C 500 | awk '{print $1}' | sort | uniq | grep '^collectd' > /var/tmp/collectd.mqtt.txt

metrics=`cat /var/tmp/collectd.mqtt.txt`

device="{\"identifiers\": \"collectd\", \"name\": \"Collectd\", \"model\": \"$HA_HOSTNAME\"}"

for metric in $metrics
do
    node_name=`echo $metric | cut -d'/' -f3`
    metric_name=`echo $metric | cut -d'/' -f4`
    unique_id=`echo "${node_name}_${metric_name}" | sed 's/-/_/g'`
    if [[ "$node_name" =~ ^cpu-[0-9] ]]
    then      
        bashio::log.info "Processing metric: $metric ($node_name/$metric_name)"
        data="{\"name\": \"${node_name} ${metric_name}\", \"state_topic\": \"$metric\", \"unique_id\": \"${unique_id}\", \"unit_of_measurement\": \"%\", \"value_template\": \"{{ value.split(':')[1] | round(1) }}\", \"state_class\": \"measurement\", \"icon\": \"mdi:cpu-64-bit\", \"device\": $device}"
        bashio::log.info "mosquitto_pub -r -h core-mosquitto -p 1883 -u $MQTT_USER -P $MQTT_PASSWORD -t \"$metric\" -m \"$data\""
        mosquitto_pub -r -h core-mosquitto -p 1883 -u $MQTT_USER -P $MQTT_PASSWORD -t "$metric" -m "$data"
    fi
done
