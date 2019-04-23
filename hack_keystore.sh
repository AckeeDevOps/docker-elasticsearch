#!/bin/bash

if [[ ! -L /usr/share/elasticsearch/config/elasticsearch.keystore ]];then
	if [[ ! -f /usr/share/elasticsearch/data/elasticsearch.keystore ]];then
		echo "Hacking keystore..."
		/usr/share/elasticsearch/bin/elasticsearch-keystore create
		mv /usr/share/elasticsearch/config/elasticsearch.keystore /usr/share/elasticsearch/data
	fi
	echo "Create keystore symlink"
	ln -s /usr/share/elasticsearch/data/elasticsearch.keystore /usr/share/elasticsearch/config/
fi
