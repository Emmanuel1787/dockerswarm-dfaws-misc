#!/bin/bash
. ./api-helpers.sh

set -o nounset

for reponame in $projects
do
  for teamname in $teams
  do
    eval $call_dtr/repositories/${org}/${reponame}/teamAccess/${teamname} -XDELETE
  done
done
