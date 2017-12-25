# https://github.com/elastic/elasticsearch-docker
FROM docker.elastic.co/elasticsearch/elasticsearch:6.1.0

ENV ES_JAVA_OPTS -Xms512m -Xmx512m
ENV ELASTIC_PASSWORD PleaseChangeMe
ENV CERTS_DIR /usr/share/elasticsearch/config/x-pack/certificates

RUN yum install -y epel-release
RUN yum install -y nodejs npm
RUN npm install elasticdump

# Add your elasticsearch plugins setup here
# Example: RUN elasticsearch-plugin install analysis-icu
