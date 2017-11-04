#!/bin/bash
. ./env.sh
set -e

UCP_CA="$UCP_BUNDLE/ca.pem"
DTR_CA="$CERTS_PATH/dtr-ca.pem"
DTR_CERT="$CERTS_PATH/dtr-cert.pem"
DTR_KEY="$CERTS_PATH/dtr-key.pem"

test -f $UCP_CA
test -f $DTR_CA
test -f $DTR_CERT
test -f $DTR_KEY

docker run -it --rm docker/dtr:${DTR_TAG} \
  reconfigure \
  --ucp-username "${ADMIN_USERNAME}" \
  --ucp-password "${ADMIN_PASSWORD}" \
  --ucp-url "https://${UCP_HOST}" \
  --ucp-ca "$(cat $UCP_CA)" \
  --dtr-external-url "https://${DTR_HOST}:443" \
  --dtr-ca "$(cat $DTR_CA)" \
  --dtr-cert "$(cat $DTR_CERT)" \
  --dtr-key "$(cat $DTR_KEY)"
