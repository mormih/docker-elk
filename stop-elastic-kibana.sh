#!/usr/bin/env bash
#iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT
#service iptables save
#service iptables restart
#curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose
#chmod +x /usr/bin/docker-compose
docker-compose -f ./elastic-kibana.yml stop
