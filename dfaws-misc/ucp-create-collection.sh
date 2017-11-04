#!/bin/bash
. ./api-helpers.sh

set -o nounset

parent=$(dirname $spec)
leaf=$(basename $spec)

parent_id=$(col=$parent dsh=t ./ucp-get-collection.sh | jq -r .id)

if [ "$parent_id" == "null" ]
then
  >&2 echo "no such parent $parent"
  exit 1
fi

collection=$(cat <<EOT
{
  "name": "${leaf}",
  "parent_id": "${parent_id}"
}
EOT
)

eval $put_ucp -XPOST $tail_ucp/collections --data-raw "'$collection'"
