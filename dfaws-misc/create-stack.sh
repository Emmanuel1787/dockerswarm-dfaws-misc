#!/bin/bash
. ./env.sh
set -e
set -o pipefail

PARAMETERS="${TEMPLATES_PATH}/${STACK_EDITION}/params.json.tmpl"
PARAMETERS_OUT="${TMPDIR}/parameters.json"
TEMPLATE="${STACK_EDITION}/${STACK_VERSION}.json"

if [ -n "${TEMPLATES_BUCKET_NAME}" ]
then
  TEMPLATE_ARG="--template-url https://${TEMPLATES_BUCKET_NAME}.s3.amazonaws.com/${BUCKET_PATH}/${TEMPLATE}"
else
  if [ ! -f ${TEMPLATES_PATH} ]
  then
    >&2 echo "Couldn't find the stack template file: '${TEMPLATES_PATH}/${TEMPLATE}'"
    exit 1
  fi
  TEMPLATE_ARG="--template-body file://${TEMPLATES_PATH}/${TEMPLATE}"
fi

if [ ! -f ${PARAMETERS} ]
then
  >&2 echo "Couldn't find the parameter template file: '${PARAMETERS}'"
  exit 1
fi

cat ${PARAMETERS} | gomplate > ${PARAMETERS_OUT}

aws cloudformation create-stack \
  --stack-name ${STACK_NAME} \
  --parameters "file://${PARAMETERS_OUT}" \
  ${TEMPLATE_ARG} \
  --tags \
    Key=product,Value=${STACK_PRODUCT} \
    Key=environment,Value=${STACK_ENV} \
  --capabilities CAPABILITY_IAM

