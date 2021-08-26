#!/bin/bash
ufw disable
filebeat modules enable system
filebeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["localhost:9200"]'

