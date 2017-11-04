#!/bin/bash
BINDIR="./bin"
mkdir -p $BINDIR

#gomplate
GOMPLATE="$BINDIR/gomplate"
curl -L https://github.com/hairyhenderson/gomplate/releases/download/v1.9.1/gomplate_linux-amd64-slim > $GOMPLATE
chmod +x $GOMPLATE

#jq
JQ="$BINDIR/jq"
curl -L https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 > $JQ
chmod +x $JQ
