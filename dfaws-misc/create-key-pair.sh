#!/bin/bash
. ./env.sh
set -e
set -o nounset

mkdir -p ${KEYS_PATH}

if [ ! -f ${SSH_KEY} ]
then
  ssh-keygen -f ${SSH_KEY}
else
  >&2 echo "Keyfile ${SSH_KEY} already exists"
  exit 1
fi
