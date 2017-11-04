#!/bin/bash
. ./env.sh
set -o nounset

aws --out json --region ${AWS_DEFAULT_REGION} ec2 describe-vpcs \
  --filters Name=tag:Name,Values=${VPC_NAME} \
  | jq -r '.Vpcs[0].VpcId'
