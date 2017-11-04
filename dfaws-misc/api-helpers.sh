#!/bin/bash
. ./env.sh

content_type="-H 'Content-Type: application/json'"

if [ "${dsh}" != 't' ]
then
  show_headers="-i"
else
  show_headers="-s"
fi

head_ucp="curl --cacert ${UCP_BUNDLE}/ca.pem --cert ${UCP_CERT} --key ${UCP_KEY} $show_headers"
tail_ucp="https://${UCP_HOST}"
call_ucp="$head_ucp $tail_ucp"
put_ucp="$head_ucp $content_type"

head_dtr="curl -k -u '${USERNAME:-$ADMIN_USERNAME}:${PASSWORD:-$ADMIN_PASSWORD}' $show_headers"
tail_dtr="https://${DTR_HOST}/api/v0"
call_dtr="$head_dtr $tail_dtr"
put_dtr="$head_dtr $content_type"
