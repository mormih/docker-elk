# https://github.com/elastic/elasticsearch-docker
FROM docker.elastic.co/elasticsearch/elasticsearch-oss:6.1.1

ENV ES_JAVA_OPTS -Xms512m -Xmx512m -cp plugins/search-guard-6/
ENV LC_ALL en_US.utf8

ADD curator/curator.repo /etc/yum.repos.d/
ADD curator/curator.yml  /root/.curator/
ADD curator/shrink-actions.yml  /root/.curator/

RUN yum install -y epel-release
RUN yum install -y nano less nodejs npm openssl cronie elasticsearch-curator
RUN npm install elasticdump
ADD curator/curator-crontab  /etc/cron.d/
ADD ./run-elastic.sh  /usr/bin/


# Add your elasticsearch plugins setup here
# Example: RUN elasticsearch-plugin install analysis-icu

RUN yes | bin/elasticsearch-plugin install -b com.floragunn:search-guard-6:6.1.1-20.1
#RUN chmod +x plugins/search-guard-6/tools/*.sh && plugins/search-guard-6/tools/install_demo_configuration.sh
ENTRYPOINT ["/usr/bin/bash" , "/usr/bin/run-elastic.sh"]
