#!/bin/bash
./dtr-detailed-health.sh | jq -r '.replica_health | to_entries | .[] | select (.value == "OK") | .key'
