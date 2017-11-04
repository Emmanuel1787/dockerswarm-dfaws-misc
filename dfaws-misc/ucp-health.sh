#!/bin/bash
. ./env.sh
curl --cacert ${UCP_BUNDLE}/ca.pem --cert ${UCP_CERT} --key ${UCP_KEY} --max-time 30 https://${UCP_HOST}/nodes | jq '.[] | select(.Spec.Role=="manager") | .Status'
