# Home Assistant App: Collectd

Collectd is a daemon which collects system performance statistics periodically and provides mechanisms to store the values in a variety of ways, for example in RRD files.

## Modules enabled by default

- cpu
- cpufreq
- df
- disk
- entropy
- irq
- load
- memory
- processes
- sensors
- smart
- swap
- uptime
- users

## MQTT

Collectd will publish data to MQTT server. You can view the data with by running this command on your Home Assistant server.

    mosquitto_sub -h core-mosquitto -p 1883 -u <USER> -P <PASSWORD> -t collectd/# -v

Here an example of the data displayed.

    collectd/<HOSTNAME>/cpu-0/cpu-user 1774973019.970:6.50015158620266

You can access the data by creating sensors in configration.yaml file. For example add this line in configuration.yaml file.

    mqtt: !include collectd.yaml

Then create collectd.yaml file with this kind of content.

    sensor:
      - name: CPU 0 user
        state_topic: collectd/<HOSTNAME>/cpu-0/cpu-user
        unit_of_measurement: '%'
        value_template: "{{ (value.split(':')[1].split('\0')[0] | float(0)) | round(1) }}"
        unique_id: cpu_0_user
        state_class: measurement
        icon: 'mdi:cpu-64-bit'
        device:
          identifiers: device_id
          name: Device Name
          model: Device Model
          manufacturer: Device Manufacturer