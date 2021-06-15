#!/usr/bin/env bash

TEMP=/tmp
O="Dev"
C="ES"
ST="Madrid"
L="Madrid"
CN="EvilCorp"
expirationDays=36500


if [ ! -f ${TEMP}/ca.key ]; then
    rm -f ${TEMP}/ca.crt
    # Create non password protected root key
    openssl genrsa -out ${TEMP}/ca.key 4096
fi

if [ ! -f ${TEMP}/ca.crt ]; then
    # Create and self sign the Root Certificate
    openssl req -x509 -new -nodes -key ${TEMP}/ca.key -sha256 -days ${expirationDays} \
        -out ${TEMP}/ca.crt -subj "/C=${C}/ST=${ST}/L=${L}/O=${O}/CN=${CN}"
fi

echo "Generated CA..."
openssl x509 -in ${TEMP}/ca.crt -text -noout -purpose