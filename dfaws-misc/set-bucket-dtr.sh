#!/bin/bash
. ./env.sh
set -o nounset

curl -v --write-out '%{http_code}' -k -u "${ADMIN_USERNAME}:${ADMIN_PASSWORD}" \
  -X PUT "https://$DTR_HOST/api/v0/admin/settings/registry/simple" \
  -d "{\"storage\":{\"delete\":{\"enabled\":true},\"maintenance\":{\"readonly\":{\"enabled\":false}},\"s3\":{\"rootdirectory\":\"\",\"region\":\"${REGION:-$AWS_DEFAULT_REGION}\",\"regionendpoint\":\"${REGION_ENDPOINT:-""}\",\"bucket\":\"${S3_BUCKET_NAME}\",\"accesskey\":\"${ACCESS_KEY:-""}\",\"secretkey\":\"${SECRET_KEY:-""}\",\"secure\": true}}}"
