#!/bin/bash
. "${BASH_SOURCE%/*}/env.sh"
openssl s_client -connect $UCP_HOST:443 -showcerts </dev/null 2>/dev/null | openssl x509 -outform PEM | sudo tee /etc/pki/trust/anchors/ucp-ca.crt
openssl s_client -connect $DTR_HOST:443 -showcerts </dev/null 2>/dev/null | openssl x509 -outform PEM | sudo tee /etc/pki/trust/anchors/dtr-ca.crt
sudo update-ca-certificates
sudo systemctl restart docker
