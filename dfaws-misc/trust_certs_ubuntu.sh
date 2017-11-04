#!/bin/bash
. "${BASH_SOURCE%/*}/env.sh"
export DOMAIN_NAME=$DTR_HOST
openssl s_client -connect $DOMAIN_NAME:443 -showcerts </dev/null 2>/dev/null | openssl x509 -outform PEM | tee /tmp/cert.pem
sudo cp /tmp/cert.pem /usr/local/share/ca-certificates/$DOMAIN_NAME.crt
sudo update-ca-certificates
sudo service docker restart
