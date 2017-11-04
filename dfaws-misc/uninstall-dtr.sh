#!/bin/bash
. ./env.sh

docker run -it --rm \
  docker/dtr:${DTR_TAG} \
  destroy \
  --ucp-username "${ADMIN_USERNAME}" \
  --ucp-password "${ADMIN_PASSWORD}" \
  --ucp-url "https://${UCP_HOST}:443"
