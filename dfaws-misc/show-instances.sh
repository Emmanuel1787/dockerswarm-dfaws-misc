#!/bin/bash
. ./env.sh
echo "MANAGERS"
##managers
aws --out table ec2 describe-instances \
  --filters Name=instance-state-name,Values=running,Name=tag:product,Values=${STACK_PRODUCT},Name=tag:aws:cloudformation:stack-name,Values=${STACK_NAME},Name=tag:swarm-node-type,Values=manager \
  --query 'Reservations[*].Instances[*].[InstanceId,PrivateDnsName,PublicDnsName]'

echo "WORKERS"
##workers
aws --out table ec2 describe-instances \
  --filters Name=instance-state-name,Values=running,Name=tag:product,Values=${STACK_PRODUCT},Name=tag:aws:cloudformation:stack-name,Values=${STACK_NAME},Name=tag:swarm-node-type,Values=worker \
  --query 'Reservations[*].Instances[*].[InstanceId,PrivateDnsName,PublicDnsName]'
