#!/bin/bash

set -eo pipefail

if [[ ! -f /usr/share/elasticsearch/data/elasticsearch.keystore ]]; then
  /usr/share/elasticsearch/bin/elasticsearch-keystore create
  cp /usr/share/elasticsearch/config/elasticsearch.keystore /usr/share/elasticsearch/data
fi
cp /usr/share/elasticsearch/data/elasticsearch.keystore /usr/share/elasticsearch/config/

source /usr/local/bin/docker-entrypoint.sh
