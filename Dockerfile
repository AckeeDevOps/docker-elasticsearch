FROM docker.elastic.co/elasticsearch/elasticsearch:6.4.3

MAINTAINER tomas.hejatko@gmail.com

# Kubernetes requires swap is turned off, so memory lock is redundant
ENV MEMORY_LOCK false

COPY --chown=elasticsearch:elasticsearch config/elasticsearch.yml /usr/share/elasticsearch/config/
COPY --chown=elasticsearch:elasticsearch config/log4j2.properties /usr/share/elasticsearch/config/

RUN rm -Rf /usr/share/elasticsearch/x-pack

RUN rm -Rf /usr/share/elasticsearch/modules/x-pack*

RUN rm -Rf /usr/share/elasticsearch/plugins/x-pack*

RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch discovery-gce
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch repository-gcs
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch analysis-icu

#COPY stackdriver.repo /etc/yum.repos.d/google-cloud-monitoring.repo

RUN yum -y update
RUN yum -y -q install redhat-lsb-core sudo curl
#RUN sudo yum -y install stackdriver-agent --nogpgcheck

COPY hack_keystore.sh /opt/01-hack_keystore.sh
COPY ackee_entrypoint.sh /ackee_entrypoint.sh

RUN cp /usr/local/bin/docker-entrypoint.sh /opt/03-original-entrypoint.sh && mv /ackee_entrypoint.sh /usr/local/bin/docker-entrypoint.sh
