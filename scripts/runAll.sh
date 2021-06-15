#!/usr/bin/env bash

subjectAltName="$1"

if [ "$#" -ne 1 ]; then
    echo "subjectAltName is required!"
    exit 1
fi

rm -f /tmp/*.{crt,key,csr,srl}
./scripts/generate_ca.sh
./scripts/generate_certs.sh ${subjectAltName}