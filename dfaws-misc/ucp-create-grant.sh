#!/bin/bash
. ./api-helpers.sh

set -o nounset
set -e

export dsh='t'

objectID=$(col=${col} ./ucp-get-collection.sh | jq -r '.id')
subjectID=$(./ucp-list-accounts.sh | jq -r ".accounts[] | select(.name==\"${account}\") | .id")
roleID=$(./ucp-get-roles.sh | jq -r ".[] | select(.name==\"${role}\") | .id")

eval $put_ucp -XPUT $tail_ucp/collectionGrants/${subjectID}/${objectID}/${roleID}
