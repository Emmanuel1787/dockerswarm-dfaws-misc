#!/bin/bash
. ./api-helpers.sh

set -o nounset

path="${col}"
eval $call_ucp/collectionByPath?path=${path}
