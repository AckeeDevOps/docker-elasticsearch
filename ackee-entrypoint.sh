#!/bin/bash

set -eo pipefail

if [[ ! -f /usr/share/elasticsearch/data/elasticsearch.keystore ]]; then
  /usr/share/elasticsearch/bin/elasticsearch-keystore create
  mv /usr/share/elasticsearch/config/elasticsearch.keystore /usr/share/elasticsearch/data
fi
ln -s /usr/share/elasticsearch/data/elasticsearch.keystore /usr/share/elasticsearch/config/

source /usr/local/bin/docker-entrypoint.sh
