#!/bin/bash
. ./env.sh
set -e
set -o nounset

aws ec2 \
  import-key-pair \
  --key-name "${KEY_NAME}" \
  --public-key-material file://${SSH_KEY}.pub
