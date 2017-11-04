#!/bin/bash
. ./env.sh

EXTRA_FILTER=""

if [ -n "${SG}" ]
then
  case "${SG}" in
    node)
      SG="NodeVpcSG"
      ;;
    ucp)
      SG="UCPLoadBalancerSG"
      ;;
    mng)
      SG="ManagerVpcSG"
      ;;
    dtr)
      SG="DTRLoadBalancerSG"
      ;;
    ext)
      SG="ExternalLoadBalancerSG"
      ;;
    man)
      SG="ManualLoadBalancerSG"
      ;;
    web)
      SG="WebsLoadBalancerSG"
      ;;
    swarm)
      SG="SwarmWideSG"
      ;;
    *)
      ;;
  esac
  EXTRA_FILTER=",Name=tag:aws:cloudformation:logical-id,Values=${SG}"
fi

aws --out json ec2 describe-security-groups \
  --filters "Name=tag:product,Values=${STACK_PRODUCT},Name=tag:aws:cloudformation:stack-name,Values=${STACK_NAME}${EXTRA_FILTER}" \
