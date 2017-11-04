#!/bin/bash
. ./env.sh
set -o nounset

docker run -it --rm \
  docker/dtr:${DTR_TAG} \
  join \
  --ucp-url "https://${UCP_HOST}" \
  --ucp-username "${ADMIN_USERNAME}" \
  --ucp-password "${ADMIN_PASSWORD}" \
  --replica-http-port 8000 \
  --replica-https-port 8443 \
  --ucp-node ${UCP_NODE:?} \
  --existing-replica-id ${REPLICA_ID:?}

set +o nounset
