#!/bin/bash
. ./env.sh

./get-stack-outputs.sh \
  | jq -r 'select (.OutputKey | test("\\w{3}LoginURL")) | .OutputValue'

cat <<EOT

user
${USERNAME}

pass
${PASSWORD}

EOT
