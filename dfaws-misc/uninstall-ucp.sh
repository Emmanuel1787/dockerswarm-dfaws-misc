#!/bin/bash
. ./env.sh
set -o nounset

for manager in $(./get-managers.sh)
do
  echo $manager

  ssh -t -i ${SSH_KEY} docker@${manager} \
  docker run --rm \
    --name ucp \
    -v /var/run/docker.sock:/var/run/docker.sock \
    docker/ucp:${UCP_TAG} \
    uninstall-ucp --interactive
done

