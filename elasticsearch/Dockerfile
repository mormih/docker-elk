# https://github.com/elastic/elasticsearch-docker
FROM docker.elastic.co/elasticsearch/elasticsearch-oss:6.1.0

# Add your elasticsearch plugins setup here
# Example: RUN elasticsearch-plugin install analysis-icu
RUN elasticsearch-plugin install x-pack
#RUN bin/x-pack/setup-passwords auto
ADD ./exported .
RUN find ./exported -name '*.json' -exec elasticdump --output=http://localhost:9200/.kibana --type=data --input={} \;
