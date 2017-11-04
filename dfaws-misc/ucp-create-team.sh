#!/bin/bash
. ./api-helpers.sh
set -o nounset

team=$(cat <<EOT
{
  "name": "$name",
  "description": "${name:-description}"
}
EOT
)

eval $put_ucp -XPOST ${tail_ucp}/accounts/${org}/teams --data-raw "'$team'"
