FROM docker.elastic.co/elasticsearch/elasticsearch:7.12.0

MAINTAINER tomas.hejatko@gmail.com

# Kubernetes requires swap is turned off, so memory lock is redundant
ENV MEMORY_LOCK false

COPY config/elasticsearch.yml /usr/share/elasticsearch/config/

RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch discovery-gce
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch repository-gcs
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch analysis-icu

COPY ackee-entrypoint.sh /ackee-entrypoint.sh

ENTRYPOINT ["/ackee-entrypoint.sh"]
