#!/bin/bash
. ./api-helpers.sh
set -o nounset

content=$(cat <<EOT
{
  "isAdmin": ${admin:-false}
}
EOT
)

eval $put_ucp -XPUT ${tail_ucp}/accounts/${org}/teams/${team}/members/${user} -d "'$content'"
