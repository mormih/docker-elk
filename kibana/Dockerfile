# https://github.com/elastic/kibana-docker
FROM docker.elastic.co/kibana/kibana-oss:6.1.1

# Add your kibana plugins setup here
# Example: RUN kibana-plugin install <name|url>
RUN bin/kibana-plugin install https://search.maven.org/remotecontent?filepath=com/floragunn/search-guard-kibana-plugin/6.1.1-8/search-guard-kibana-plugin-6.1.1-8.zip
