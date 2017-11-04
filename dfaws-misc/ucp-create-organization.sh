#!/bin/bash
. ./api-helpers.sh

set -o nounset

account=$(cat <<EOT
{
  "fullName": "${fullName:-$name}",
  "isOrg": true,
  "name": "$name",
  "searchLDAP": false
}
EOT
)

eval $put_ucp -XPOST $tail_ucp/accounts/ --data-raw "'$account'"
