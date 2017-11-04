#!/bin/bash
. ./env.sh

for LB in $(aws --out json elb describe-load-balancers |
  jq -cr ".LoadBalancerDescriptions[] | select( .LoadBalancerName | test (\"^${STACK_NAME}-.*\") ) | [ .DNSName, .CanonicalHostedZoneNameID, (.DNSName | capture(\"${STACK_NAME}-(?<blah>[A-Z]{3})[A-Z]+-.*\"; \"ig\") | .blah) ]")
do
  TYPE=$(echo "${LB}" | jq -r '.[2]')

  set -a

  ELB=$(echo "${LB}" | jq -r '.[0]')
  ELB_ZONE_ID=$(echo "${LB}" | jq -r '.[1]')
  HOST_NAME=${TYPE,,}-${STACK_NAME}.${DDC_DOMAIN}

  HOSTED_ZONE_ID=$(
    aws --out json route53 list-hosted-zones |
    jq -r ".HostedZones[] | select(.Name==\"${DDC_DOMAIN}.\" and .Config.PrivateZone==false) | .Id" |
    cut -d'/' -f3
  )

  set +a

  CHANGE_BATCH=$(mktemp)
  cat "${TEMPLATES_PATH}/upsert-alias-record-set.json.tmpl" | gomplate > "${CHANGE_BATCH}"

  aws --out json route53 change-resource-record-sets --hosted-zone-id "${HOSTED_ZONE_ID}" --change-batch "file://${CHANGE_BATCH}"
  rm ${CHANGE_BATCH}
done
