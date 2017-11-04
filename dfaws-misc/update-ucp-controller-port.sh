#!/bin/bash
docker service update --add-env CONTROLLER_PORT=5443 ucp-agent
