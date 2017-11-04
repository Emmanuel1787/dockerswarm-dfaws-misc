#!/bin/bash
set -o nounset

BASE="$(readlink -f ${BASH_SOURCE%/*})"

set -a

[ -f "${BASE}/.env" ] && . ${BASE}/.env
[ -d "${BASE}/bin" ] && PATH="${PATH}:${BASE}/bin"

TMPDIR="${BASE}/tmp"
mkdir -p "${TMPDIR}"

#general params
AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:-us-east-2}
STACK_PRODUCT=${STACK_PRODUCT:-bl}
STACK_ENV=${STACK_ENV:-test}
STACK_NAME=${STACK_NAME:-${STACK_PRODUCT}-${STACK_ENV}}
STACK_EDITION=${STACK_EDITION:-ee}
STACK_VERSION=${STACK_VERSION:-latest}
TEMPLATES_PATH="${BASE}/templates"
CERTS_PATH="${BASE}/certs/${STACK_NAME}"
USE_MOD_HOSTS=${USE_MOD_HOSTS:-f}
USE_MOD_UCP=${USE_MOD_UCP:-f}
USE_MOD_DTR=${USE_MOD_DTR:-f}
USE_MOD_EXT=${USE_MOD_EXT:-f}
REFRESH_HOSTS=${REFRESH_HOSTS:-f}
BUCKET_PATH=${BUCKET_PATH:-templates}
UCP_BUNDLE=${TMPDIR}/${STACK_NAME}/bundle_${USERNAME:-}
UCP_CERT="${UCP_BUNDLE}/cert.pem"
UCP_KEY="${UCP_BUNDLE}/key.pem"
VPC_NAME=${VPC_NAME:-$ASSOCIATED_VPC}
KEYS_PATH="${BASE}/keys/${STACK_NAME}"

#cloudformation stack params
LICENSE=${LICENSE}
KEY_NAME=${KEY_NAME:-"devops"}
SYSTEM_PRUNE=${SYSTEM_PRUNE:-"yes"}
ADMIN_USERNAME=${ADMIN_USERNAME:-"admin"}
ADMIN_PASSWORD=${ADMIN_PASSWORD}
MANAGER_NUMBER=${MANAGER_NUMBER:-"3"}
MANAGER_TIPE=${MANAGER_TIPE:-"m4.large"}
MANAGER_DISK_TYPE=${MANAGER_DISK_TYPE:-"gp2"}
MANAGER_DISK_SIZE=${MANAGER_DISK_SIZE:-"20"}
WORKER_NUMBER=${WORKER_NUMBER:-"2"}
WORKER_TYPE=${WORKER_TYPE:-"m4.large"}
WORKER_DISK_TYPE=${WORKER_DISK_TYPE:-"gp2"}
WORKER_DISK_SIZE=${WORKER_DISK_SIZE:-"20"}

DDC_DOMAIN=${DDC_DOMAIN:-blanclabs.com}

mkdir -p "${TMPDIR}/${STACK_NAME}"

#host mods
url_cache="${TMPDIR}/${STACK_NAME}/url_cache.env"
if [ ! -f $url_cache ] || [ "$REFRESH_HOSTS"  == 't' ]
then
  aws --out json cloudformation describe-stacks --stack-name ${STACK_NAME} \
    | jq '.Stacks[0].Outputs[]' \
    | jq -r 'select (.OutputKey | test("\\w{3}LoginURL|DefaultDNSTarget"))
      | .OutputValue | ltrimstr("https://")
      | (. | scan("(Ext|DTR|UCP)") | .[0] | ascii_upcase) + "_DEFAULT_HOST=" + .' \
    > $url_cache
fi
. $url_cache

if [ "$USE_MOD_HOSTS"  == 't' ] || [ "$USE_MOD_UCP"  == 't' ]
then
  UCP_DEFAULT_HOST="ucp-${STACK_NAME}.${DDC_DOMAIN}"
fi

if [ "$USE_MOD_HOSTS"  == 't' ] || [ "$USE_MOD_DTR"  == 't' ]
then
  DTR_DEFAULT_HOST="dtr-${STACK_NAME}.${DDC_DOMAIN}"
fi

if [ "$USE_MOD_HOSTS"  == 't' ] || [ "$USE_MOD_EXT"  == 't' ]
then
  EXT_DEFAULT_HOST="ext-${STACK_NAME}.${DDC_DOMAIN}"
fi

UCP_HOST=${UCP_HOST:-$UCP_DEFAULT_HOST}
DTR_HOST=${DTR_HOST:-$DTR_DEFAULT_HOST}
EXT_HOST=${EXT_HOST:-$EXT_DEFAULT_HOST}

DTR_TAG=${DTR_TAG:-2.3.2}
UCP_TAG=${UCP_TAG:-2.2.3}

SSH_KEY="${KEYS_PATH}/${KEY_NAME}"

set +a
set +o nounset
