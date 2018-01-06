#!/bin/bash
set -e
CA_PATH=$CERTS_PATH/ca
rm -rf  $CA_PATH/certs* $CA_PATH/crl $CA_PATH/*.jks
mkdir -p $CA_PATH

if [ -z "$2" ] ; then
  unset CA_PASS TS_PASS
  read -p "Enter CA pass: " -s CA_PASS ; echo
  read -p "Enter Truststore pass: " -s TS_PASS ; echo
 else
  CA_PASS=$1
  TS_PASS=$2
fi

mkdir -p $CA_PATH/root-ca/private $CA_PATH/root-ca/db
chmod 700 $CA_PATH/root-ca/private

cp /dev/null $CA_PATH/root-ca/db/root-ca.db
cp /dev/null $CA_PATH/root-ca/db/root-ca.db.attr
echo 01 > $CA_PATH/root-ca/db/root-ca.crt.srl
echo 01 > $CA_PATH/root-ca/db/root-ca.crl.srl

echo "Step 1. Generating root CA request"

openssl req -new \
    -config etc/root-ca.conf \
    -out $CA_PATH/root-ca/root-ca.csr \
    -keyout $CA_PATH/root-ca/private/root-ca.key \
	-batch \
	-passout pass:$CA_PASS
	
echo "Step 2. Creating root CA"

openssl ca -selfsign \
    -config etc/root-ca.conf \
    -in $CA_PATH/root-ca/root-ca.csr \
    -out $CA_PATH/root-ca/root-ca.crt \
    -extensions root_ca_ext \
	-batch \
	-passin pass:$CA_PASS
	
echo Root CA generated
	
mkdir -p $CA_PATH/signing-ca/private $CA_PATH/signing-ca/db
chmod 700 $CA_PATH/signing-ca/private
chmod 700 $CA_PATH/signing-ca/db

cp /dev/null $CA_PATH/signing-ca/db/signing-ca.db
cp /dev/null $CA_PATH/signing-ca/db/signing-ca.db.attr
echo 01 > $CA_PATH/signing-ca/db/signing-ca.crt.srl
echo 01 > $CA_PATH/signing-ca/db/signing-ca.crl.srl

echo "Step 3. Generating Signing CA request"

openssl req -new \
    -config etc/signing-ca.conf \
    -out $CA_PATH/signing-ca/signing-ca.csr \
    -keyout $CA_PATH/signing-ca/private/signing-ca.key \
	-batch \
	-passout pass:$CA_PASS

echo "Step 4. Creating signing CA"

openssl ca \
    -config etc/root-ca.conf \
    -in $CA_PATH/signing-ca/signing-ca.csr \
    -out $CA_PATH/signing-ca/signing-ca.crt \
    -extensions signing_ca_ext \
	-batch \
	-passin pass:$CA_PASS
	
echo Signing CA generated

echo "Step 5. Creating x509 PEM CA"

openssl x509 -in $CA_PATH/root-ca/root-ca.crt -out $CA_PATH/root-ca/root-ca.pem -outform PEM
openssl x509 -in $CA_PATH/signing-ca/signing-ca.crt -out $CA_PATH/signing-ca/signing-ca.pem -outform PEM

echo "Step 6. Join into the chain CA"

cat $CA_PATH/signing-ca/signing-ca.pem $CA_PATH/root-ca/root-ca.pem > $CA_PATH/chain-ca.pem

#http://stackoverflow.com/questions/652916/converting-a-java-keystore-into-pem-format

BIN_PATH="keytool"

if [ ! -z "$JAVA_HOME" ]; then
    BIN_PATH="$JAVA_HOME/bin/keytool"
fi

echo "Step 7. Import root CA to JKS keystore"

cat $CA_PATH/root-ca/root-ca.pem | "$BIN_PATH" \
    -import \
    -v \
    -keystore $CA_PATH/truststore.jks   \
    -storepass $TS_PASS  \
    -noprompt -alias root-ca-chain
