#!/bin/bash
. "${BASH_SOURCE%/*}/env.sh"
docker login -u "${USERNAME:-$ADMIN_USERNAME}" -p "${PASSWORD:-$ADMIN_PASSWORD}" "${DTR_HOST}"
