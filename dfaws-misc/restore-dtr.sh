#!/bin/bash
. ./env.sh
set -o nounset

docker run -i --rm \
  docker/dtr:${DTR_TAG} \
  restore \
  --ucp-node ${UCP_NODE:?} \
  --ucp-url "https://${UCP_HOST}" \
  --dtr-external-url "https://${DTR_HOST}" \
  --ucp-username "${ADMIN_USERNAME}" \
  --ucp-password "${ADMIN_PASSWORD}" \
  --replica-http-port 8000 \
  --replica-https-port 8443 \
  --dtr-ca "$(cat $CERTS_PATH/dtr-ca.pem)" \
  --dtr-cert "$(cat $CERTS_PATH/dtr-cert.pem)" \
  --dtr-key "$(cat $CERTS_PATH/dtr-key.pem)" \
  < ${TMPDIR}/dtr-backup.tar

set +o nounset
