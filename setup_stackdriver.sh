#!/bin/bash

cd /opt/stackdriver/collectd/etc/collectd.d/ && sudo curl -O https://raw.githubusercontent.com/Stackdriver/stackdriver-agent-service-configs/master/etc/collectd.d/elasticsearch-1.conf

/opt/stackdriver/collectd/sbin/stackdriver-collectd -C /etc/stackdriver/collectd.conf