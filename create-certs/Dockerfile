# https://github.com/elastic/elasticsearch-docker
FROM docker.elastic.co/elasticsearch/elasticsearch-oss:6.1.1
RUN yum install -y less openssl

ADD ./search-guard-ssl /usr/share/elasticsearch/search-guard-ssl
