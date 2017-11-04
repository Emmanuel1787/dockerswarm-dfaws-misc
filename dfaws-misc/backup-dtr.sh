#!/bin/bash
. ./env.sh
set -o nounset

docker run -i --rm docker/dtr:${DTR_TAG} backup \
  --ucp-url "https://${UCP_HOST}" \
  --ucp-ca "$(cat ${CERTS_PATH}/ucp-ca.pem)" \
  --existing-replica-id ${REPLICA_ID} \
  --ucp-username "${ADMIN_USERNAME}" \
  --ucp-password "${ADMIN_PASSWORD}" \
  > ${TMPDIR}/dtr-backup.tar
