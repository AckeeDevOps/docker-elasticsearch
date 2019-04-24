#!/bin/bash

if [[ ! -f /usr/share/elasticsearch/config/elasticsearch.keystore ]];then
	if [[ ! -f /usr/share/elasticsearch/data/elasticsearch.keystore ]];then
		echo "Hacking keystore..."
		/usr/share/elasticsearch/bin/elasticsearch-keystore create
		chown elasticsearch:elasticsearch /usr/share/elasticsearch/config/elasticsearch.keystore
		cp /usr/share/elasticsearch/config/elasticsearch.keystore /usr/share/elasticsearch/data
	fi
	echo "Copy keystore from persitent storage"
	cp -a /usr/share/elasticsearch/data/elasticsearch.keystore /usr/share/elasticsearch/config/
fi
