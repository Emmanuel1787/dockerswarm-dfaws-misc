#!/bin/bash
. ./env.sh

ON=${ON:-true}
if $ON
then
  AUTHORIZE="authorize"
else
  AUTHORIZE="revoke"
fi

IN=${IN:-true}
if $IN
then
  DIRECTION="ingress"
else
  DIRECTION="egress"
fi

FILTER=""
if [ -n "$SSG" ]
then
  FILTER="--source-group \"$SSG\""
else
  FILTER="--cidr \"${CIDR:-0.0.0.0/0}\""
fi

EXTRA=""
if [ -n "$PORT" ]
then
  EXTRA="--port ${PORT}"
fi

eval aws ec2 ${AUTHORIZE}-security-group-${DIRECTION} \
  ${FILTER} \
  --group-id "${SG:?}" \
  --protocol "${PROTOCOL:-'tcp'}" \
  ${EXTRA}
