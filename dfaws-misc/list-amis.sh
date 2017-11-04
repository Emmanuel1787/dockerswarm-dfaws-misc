#!/bin/bash
. ./env.sh
set -o nounset

aws --out json --region ${AWS_DEFAULT_REGION} \
  ec2 describe-images --owners self \
  | jq -c '.Images[] | {ImageId,State,Name,TagName:((.Tags // []) | from_entries | .Name),CreationDate}'
