#!/bin/bash
. ./env.sh

#MANAGERS"
aws --out json ec2 describe-instances \
  --filters Name=instance-state-name,Values=running,Name=tag:product,Values=${STACK_PRODUCT},Name=tag:aws:cloudformation:stack-name,Values=${STACK_NAME},Name=tag:swarm-node-type,Values=manager \
  --query 'Reservations[*].Instances[*].[PrivateDnsName,Placement.AvailabilityZone,InstanceId]' \
  | jq -rc ".[] | .[] | \"Host ${STACK_NAME}-manager-\" + (.[1][-1:] ) + \"\\n \" + \"HostName \" + .[0] + \"\\n\""

#WORKERS
aws --out json ec2 describe-instances \
  --filters Name=instance-state-name,Values=running,Name=tag:product,Values=${STACK_PRODUCT},Name=tag:aws:cloudformation:stack-name,Values=${STACK_NAME},Name=tag:swarm-node-type,Values=worker \
  --query 'Reservations[*].Instances[*].[PrivateDnsName,InstanceId]' \
    | jq -rc ".[] | .[] | \"Host ${STACK_NAME}-worker-\" + (.[1][2:]) + \"\\n \" + \"HostName \" + .[0] + \"\\n\""
