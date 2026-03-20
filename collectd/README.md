# Home Assistant App: collectd

Collectd is a daemon which collects system performance statistics periodically and provides mechanisms to store the values in a variety of ways, for example in RRD files.

## Modules enabled

- cpu
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
- write_graphite

If you to export date to Prometheus, you have to setup a graphite-exporter server.