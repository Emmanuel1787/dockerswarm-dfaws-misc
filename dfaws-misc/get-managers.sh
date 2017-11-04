#!/bin/bash
. ./env.sh
TYPE=${TYPE:-1}
aws --out json ec2 describe-instances \
  --filters Name=instance-state-name,Values=running,Name=tag:product,Values=${STACK_PRODUCT},Name=tag:aws:cloudformation:stack-name,Values=${STACK_NAME},Name=tag:swarm-node-type,Values=manager \
  --query "Reservations[*].Instances[*].[PrivateDnsName,PublicDnsName]" \
  | jq -r ".[] | .[] | .[${TYPE}]"
