#!/usr/bin/env bash

# Create certificates

subjectAltName="$1"

TEMP=/tmp
O="Develop"
C="ES"
ST="Madrid"
L="Madrid"
CN="EvilCorp"
expirationDays=36500

# Create the certificate key
openssl genrsa -out ${TEMP}/${subjectAltName}.key 2048

# Create the signing (csr)
# The certificate signing request is where you specify the details for the certificate you want to generate.
# This request will be processed by the owner of the Root key (you in this case since you create it earlier) 
# to generate the certificate.
# Important: Please mind that while creating the signign request is important to specify the Common Name
# providing the IP address or domain name for the service, otherwise the certificate cannot be verified.

openssl req -nodes -newkey rsa:2048 \
    -keyout ${TEMP}/${subjectAltName}.key \
    -out ${TEMP}/${subjectAltName}.csr \
    -subj "/C=${C}/ST=${ST}/L=${L}/O=${O}/CN=${CN}" \
    -addext "subjectAltName=DNS:${subjectAltName}"

# Generate the certificate using the mydomain csr and key along with the CA Root key
openssl x509 -req -in ${TEMP}/${subjectAltName}.csr -CA ${TEMP}/ca.crt -CAkey ${TEMP}/ca.key -CAcreateserial \
    -extfile <(printf "subjectAltName=DNS:${subjectAltName}") \
    -out ${TEMP}/${subjectAltName}.crt -days ${expirationDays} -sha256

echo "Generated cert..."
openssl x509 -in ${TEMP}/${subjectAltName}.crt -text -noout -purpose

chown 1000:1000 ${TEMP}/*.crt ${TEMP}/*.csr ${TEMP}/*.srl ${TEMP}/*.key