#!/bin/bash
. ./api-helpers.sh
set -o nounset

public=${public:-private}

for project in $projects
do
  repo=$(cat <<EOT
{
  "name": "$project",
  "shortDescription": "$project repository",
  "longDescription": "$project repository",
  "visibility": "$public",
  "scanOnPush": false,
  "immutableTags": true,
  "enableManifestLists": true
}
EOT
)
  eval $put_dtr -XPOST $tail_dtr/repositories/${org} --data-raw "'$repo'"
done
