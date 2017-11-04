#!/bin/bash
docker node ls -q \
  | xargs -n1 -I{} docker node inspect -f '{{json .}}' {} \
  | jq '{
    ID,
    Role:(.Spec.Role),
    NodeLabels:(.Spec.Labels),
    EngineLabels:(.Description.Engine.Labels)
  }'
