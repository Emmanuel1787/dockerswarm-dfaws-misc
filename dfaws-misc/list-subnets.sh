#!/bin/bash
. ./env.sh
vpcid=$(./get-vpc.sh)

aws --out json ec2 describe-subnets --filter Name=vpc-id,Values=${vpcid} \
  | jq -r '.Subnets[] | (.Tags | from_entries | select(.Name) | .Name) + " " + .SubnetId' \
  | sort -n
