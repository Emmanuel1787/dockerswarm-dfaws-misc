#!/bin/bash
. ./env.sh
curl -su "${USERNAME:-$ADMIN_USERNAME}:${PASSWORD:-$ADMIN_PASSWORD}" https://${DTR_HOST}/api/v0/meta/cluster_status
