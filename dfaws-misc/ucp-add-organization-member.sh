#!/bin/bash
. ./api-helpers.sh
set -o nounset

eval $put_ucp -XPUT ${tail_ucp}/accounts/${org}/members/${user} -d '{}'
