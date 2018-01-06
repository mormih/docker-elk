# https://github.com/elastic/elasticsearch-docker
FROM docker.elastic.co/elasticsearch/elasticsearch-oss:6.1.1

ENV ES_JAVA_OPTS -Xms512m -Xmx512m -cp plugins/search-guard-6/

RUN yum install -y epel-release
RUN yum install -y less nodejs npm openssl
RUN npm install elasticdump
RUN yes | bin/elasticsearch-plugin install -b com.floragunn:search-guard-6:6.1.1-20.1
#RUN chmod +x plugins/search-guard-6/tools/*.sh && plugins/search-guard-6/tools/install_demo_configuration.sh
# Add your elasticsearch plugins setup here
# Example: RUN elasticsearch-plugin install analysis-icu
