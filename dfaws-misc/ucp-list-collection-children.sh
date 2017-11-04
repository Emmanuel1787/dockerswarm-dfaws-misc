#!/bin/bash
. ./api-helpers.sh

set -o nounset

eval $call_ucp/collections/${name}/children
