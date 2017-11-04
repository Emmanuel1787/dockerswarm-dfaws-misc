#!/bin/bash
. ./env.sh
set -o nounset

aws --out json --region ${AWS_DEFAULT_REGION} \
  ec2 describe-vpcs \
  | jq -c ".Vpcs[] | {VpcId, Tags:(.Tags | from_entries)}"

