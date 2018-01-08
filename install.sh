#!/usr/bin/env bash
docker-compose -f ./create-certs.yml up
#iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT
#service iptables save
#service iptables restart
