#!/bin/bash
. ./api-helpers.sh

set -o nounset

eval $put_ucp -XDELETE $tail_ucp/roles/${role}
