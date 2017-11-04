#!/bin/bash
. ./env.sh
aws --out json cloudformation describe-stacks --stack-name ${STACK_NAME} |
  jq '.Stacks[0].Outputs[]'
