#!/bin/bash
set -e -o pipefail

ENTRY="dtr-nginx"
NETWORK="dtr-ol"

for out in $(docker inspect $(docker ps -qf name=${ENTRY}) | jq -r ".[] | [.NetworkSettings.Networks[\"${NETWORK}\"].IPAddress, .Name] | @csv")
do
  addr=$(echo $out | cut -d',' -f1 | tr -d \")
  name=$(echo $out | cut -d',' -f2 | tr -d \" | cut -d \- -f3)

  if [[ $(docker run --net ${NETWORK} alpine:3.4 sh -c "wget -qO - ${addr}/health" | jq -r '.Healthy') == "true" ]]
  then
    echo "$name"
  fi
done
