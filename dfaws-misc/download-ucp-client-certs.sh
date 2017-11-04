#!/bin/bash
. ./env.sh
zip_path=${TMPDIR}/${STACK_NAME}/bundle.zip
rm ${TMPDIR}/${STACK_NAME}/bundle.zip
rm -rf ${UCP_BUNDLE}
mkdir -p ${UCP_BUNDLE}
set -e
AUTHTOKEN=$(curl -sk -d "{\"username\":\"${USERNAME:-$ADMIN_USERNAME}\",\"password\":\"${PASSWORD:-$ADMIN_PASSWORD}\"}" https://${UCP_HOST}/auth/login | jq -r .auth_token)
curl -k -H "Authorization: Bearer ${AUTHTOKEN}" https://${UCP_HOST}/api/clientbundle -o ${zip_path}
unzip -d ${UCP_BUNDLE} ${zip_path}
