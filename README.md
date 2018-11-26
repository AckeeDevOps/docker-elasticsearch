# Ackee k8s Elasticsearch image + GCS backup plugin

This image is meant to be "gateway" to Elasticsearch instances running on GCE - it should not hold a data, should not ingest a data, it should just provide a endpoint to reach a ES cluster from k8s cluster.

This image is build on top of official ES image with these extras preinstalled :
* GCS repository plugin for backups - https://www.elastic.co/guide/en/elasticsearch/plugins/6.4/repository-gcs.html
* GCE discovery plugin for hosts discovery - https://www.elastic.co/guide/en/elasticsearch/plugins/6.4/discovery-gce-usage-long.html
* Stackdriver agent for advanced Stackdriver monitoring

## Configuration

It has own config configurable via these ENV variables (followed by default values) :

* CLUSTER_NAME:ackee - name of ES cluster
* ES_MASTER:true - node is master eligible
* ES_DATA:false - node holds a data
* ES_INGEST:false - node ingests a data
* HOSTNAME:$HOSTNAME - node name, default taken from env
* PROCESSORS:1 - number of available proccessors
* MEMORY_LOCK:false - lock the memory - needed when swap is present, should be set to off on k8s, because k8s always run without swap.
* HTTP_ENABLED:true - enable ES HTTP interface at port 9200
* HTTP_CORS_ENABLE:true - enable CORS (https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-http.html)
* HTTP_CORS_ALLOW_ORIGIN:* - setup CORS origin

### GCE discovery plugin options (required) :

We need dummy default values here, otherwise Elasticsearch plugin installer will complain on wrong configuration and we will not be able to build image.

* GCE_PROJECT:dummy : GCE project where container runs
* GCE_ZONE:dummy : zone of GCE project

## Backing up

Backups are done using cronjob specified in `k8s/es-backup.yml`. But before first backup (snapshot) we need to define repository.

Note : This approach is using service account of GCE instances and it must have permission to write to GCS bucket. (Storage : Write)

### Create GCS repository

    curl -XPUT http://elasticsearch:9200/_snapshot/ackee-%PROJECT_NAME%-backup?pretty -H 'Content-Type: application/json' -d '{
        "type": "gcs",
        "settings": {
            "bucket": "ackee-%PROJECT_NAME%-backup",
            "base_path": "es_backup" 
        }
    }'