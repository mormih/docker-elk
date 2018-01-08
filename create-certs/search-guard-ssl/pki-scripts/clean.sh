#!/bin/bash
set -e
echo $CERTS_PATH
rm -rf $CERTS_PATH/ca/
rm -rf $CERTS_PATH/certs/
rm -rf $CERTS_PATH/crl/
rm -rf $CERTS_PATH/*.jks
rm -rf $CERTS_PATH/*.pem
rm -rf $CERTS_PATH/*.p12
rm -rf $CERTS_PATH/*.csr
rm -rf $CERTS_PATH/*.key*
rm -rf $CERTS_PATH/*tmp*
rm -rf $CERTS_PATH/*.crl
rm -rf $CERTS_PATH/*.p7b
