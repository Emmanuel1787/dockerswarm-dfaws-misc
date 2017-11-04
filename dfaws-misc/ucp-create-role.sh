#!/bin/bash
. ./api-helpers.sh

set -o nounset

eval $put_ucp -XPOST  --data "@${file}" $tail_ucp/roles/
