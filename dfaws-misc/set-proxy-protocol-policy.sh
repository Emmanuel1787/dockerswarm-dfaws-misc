#!/bin/bash
. ./env.sh
ELB_TYPE="${ELB_TYPE:-Manual}"
POLICY_NAME="${ELB_TYPE}-ProxyProtocol-policy"
PORT="${PORT:?}"

ELB_NAME=$(aws --out json elb describe-load-balancers | jq -cr ".LoadBalancerDescriptions[] | select( .LoadBalancerName | test (\"^${STACK_NAME}-${ELB_TYPE}.*\") ) | .LoadBalancerName")

aws elb create-load-balancer-policy --load-balancer-name $ELB_NAME --policy-name $POLICY_NAME --policy-type-name ProxyProtocolPolicyType --policy-attributes AttributeName=ProxyProtocol,AttributeValue=true

if [ -n "$CLEAR" ]
then
  POLICY_NAME='[]'
fi

aws elb set-load-balancer-policies-for-backend-server --load-balancer-name $ELB_NAME --instance-port ${PORT} --policy-names ${POLICY_NAME}
