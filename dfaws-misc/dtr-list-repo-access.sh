#!/bin/bash
. ./api-helpers.sh

set -o nounset

for reponame in $projects
do
  eval $call_dtr/repositories/${org}/${reponame}/teamAccess
done
