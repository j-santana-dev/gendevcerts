#!/usr/bin/env bash

TEMP=/tmp
O="Dev"
C="ES"
ST="Madrid"
L="Madrid"
CN="EvilCorp"
expirationDays=36500

# Create Root Key
# This is the key used to sign the certificate requests

# password protected:
# openssl genrsa -des3 -out ca.key 4096

# non password protected
openssl genrsa -out ${TEMP}/ca.key 4096

# Create and self sign the Root Certificate
openssl req -x509 -new -nodes -key ${TEMP}/ca.key -sha256 -days ${expirationDays} \
    -out ${TEMP}/ca.crt -subj "/C=${C}/ST=${ST}/L=${L}/O=${O}/CN=${CN}"

echo "Generated CA..."
openssl x509 -in ${TEMP}/ca.crt -text -noout -purpose