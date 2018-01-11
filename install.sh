#!/usr/bin/env bash
curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose

./create-certs.sh
./run-elastic-kibana.sh
./run-logstash.sh