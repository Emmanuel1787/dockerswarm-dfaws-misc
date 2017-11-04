#!/bin/bash
. ./env.sh
set -o nounset

id=$(docker info -f '{{.ID}}')
date=$(date +%s)
backup_path="${TMPDIR}/backup_ucp"
mkdir -p ${backup_path}

for manager in $(./get-managers.sh)
do
  echo $manager

  ssh -i ${SSH_KEY} docker@${manager} \
  docker run --rm \
    --name ucp \
    -v /var/run/docker.sock:/var/run/docker.sock \
    docker/ucp:${UCP_TAG} \
    backup --id ${id} > "${backup_path}/ucp-backup_${date}.tar"

  if [[ ${?} -eq 0 ]]
  then
    break;
  else
    echo "Failed performing UCP backup on ${manager}"
  fi

done

