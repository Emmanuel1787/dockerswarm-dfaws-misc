#!/bin/bash
. ./env.sh
set -o nounset

ENVIRONMENT=${ENVIRONMENT:-test}
NAME="${NAME:-${PROJECT}-${ENVIRONMENT}-${WHAT}}"

aws --region ${AWS_DEFAULT_REGION} ec2 create-tags \
  --resources ${RESOURCES:?} \
  --tags \
  "Key=Name,Value=${NAME}" \
  "Key=Project,Value=${PROJECT:?}" \
  "Key=Environment,Value=${ENVIRONMENT}" \

