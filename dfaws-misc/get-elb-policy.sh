#!/bin/bash
. ./env.sh
ELB_TYPE="${ELB_TYPE:-Manual}"
POLICY_NAME="${ELB_TYPE}-ProxyProtocol-policy"
ELB_NAME=$(aws --out json elb describe-load-balancers | jq -cr ".LoadBalancerDescriptions[] | select( .LoadBalancerName | test (\"^${STACK_NAME}-${ELB_TYPE}.*\") ) | .LoadBalancerName")

aws --out json elb describe-load-balancer-policies \
  --load-balancer-name $ELB_NAME \
  | jq -j '.PolicyDescriptions[]'

aws --out json elb describe-load-balancers \
  --load-balancer-name ${ELB_NAME} \
  --query "LoadBalancerDescriptions[*].{Listeners:ListenerDescriptions,Backends:BackendServerDescriptions}" \
  | jq -j '.'
