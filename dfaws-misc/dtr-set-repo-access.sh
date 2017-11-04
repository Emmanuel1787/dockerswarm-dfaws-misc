#!/bin/bash
. ./api-helpers.sh

set -o nounset
accessLevel=${access:-read-only}

access=$(cat <<EOT
{
  "accessLevel": "$accessLevel"
}
EOT
)

for reponame in $projects
do
  for teamname in $teams
  do
    eval $put_dtr -XPUT $tail_dtr/repositories/${org}/${reponame}/teamAccess/${teamname} --data-raw "'$access'"
  done
done
