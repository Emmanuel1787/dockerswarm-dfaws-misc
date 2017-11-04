#!/bin/bash
. ./env.sh
vpcid=$(./get-vpc.sh)

aws --out json ec2 describe-security-groups --filter Name=vpc-id,Values=${vpcid}\
  | jq -r '.SecurityGroups[] | .GroupId + " " + .GroupName'
