#!/bin/bash
ufw disable
-f /etc/logstash/conf.d/logstash.conf
#/usr/share/logstash/bin/logstash --path.settings /etc/logstash/ -f /etc/logstash/conf.d/logstash.conf
#/usr/share/filebeat/bin/filebeat -e -c /etc/filebeat/filebeat.yml
