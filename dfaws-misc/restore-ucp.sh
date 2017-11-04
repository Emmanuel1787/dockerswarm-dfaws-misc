#!/bin/bash
. ./env.sh
set -o nounset

backup_path="${TMPDIR}/backup_ucp"
mkdir -p ${backup_path}

backup_file="${backup_path}/ucp-backup_${BACKUP_DATE}.tar"

if [[ ! -f "$backup_file" ]]
then
  echo "Cannot find backup_file: $backup_file"
fi

for manager in $(./get-managers.sh)
do
  echo $manager

  ssh -t -i ${SSH_KEY} docker@${manager} \
  docker run --rm \
    --name ucp \
    -v /var/run/docker.sock:/var/run/docker.sock \
    docker/ucp:${UCP_TAG} \
    restore < "${backup_file}"

  if [[ ${?} -eq 0 ]]
  then
    break;
  else
    echo "Failed performing UCP restore on ${manager}"
  fi

done

