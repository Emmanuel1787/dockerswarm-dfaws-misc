#!/bin/bash
. ./env.sh

TIMES=30
INTERVAL="60s"
COUNTER=0

while [ $COUNTER -lt $TIMES ]
do
  echo "$(date +%F\ %T) -- attempt ${COUNTER}"
  RESPONSE=$(aws --out json cloudformation describe-stacks --stack-name ${STACK_NAME} | jq '.Stacks[0].StackStatus')
  RESULT="$?"

  if [ "$RESULT" -ne 0 ]
  then
    2&< echo "remote query failed, stopping..."
    exit 1
  fi

  if [[ $RESPONSE =~ "CREATE_COMPLETE" ]]
  then
    exit 0
  fi

  COUNTER=$(($COUNTER+1))
  sleep ${INTERVAL}
done

echo "giving up..."
exit 1
