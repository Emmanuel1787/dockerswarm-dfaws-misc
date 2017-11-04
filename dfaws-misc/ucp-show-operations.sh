#!/bin/bash
export dsh='t'
. ./api-helpers.sh

set -o nounset

$call_ucp/totalRole \
  | jq '.'
