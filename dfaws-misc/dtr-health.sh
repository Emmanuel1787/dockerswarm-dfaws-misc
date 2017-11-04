#!/bin/bash
. ./env.sh
curl -i https://${DTR_HOST}/health
