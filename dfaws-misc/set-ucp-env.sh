#!/bin/bash
. "${BASH_SOURCE%/*}/env.sh"
cat <<EOT
export DOCKER_TLS_VERIFY=1
export DOCKER_CERT_PATH="${UCP_BUNDLE}"
export DOCKER_HOST=tcp://${UCP_HOST}:443
EOT
