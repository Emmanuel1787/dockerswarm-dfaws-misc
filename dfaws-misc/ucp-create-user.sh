#!/bin/bash
. ./api-helpers.sh

set -o nounset

account=$(cat <<EOT
{
  "fullName": "${fullName:-$name}",
  "isActive": true,
  "isAdmin": ${admin:-false},
  "isOrg": false,
  "name": "$name",
  "password": "$password",
  "searchLDAP": false
}
EOT
)

eval $put_ucp -XPOST $tail_ucp/accounts/ --data-raw "'$account'"

echo -e "\n"
echo "$name \`$password\`"
