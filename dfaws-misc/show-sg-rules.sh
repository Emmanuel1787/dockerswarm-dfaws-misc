#!/bin/bash
. ./env.sh
set -o nounset

./get-sg.sh \
  | jq -r '.SecurityGroups[] | {
  "GroupId": .GroupId,
  "GroupName": .GroupName,
  "Ingress": [
    .IpPermissions[] | [
      .IpProtocol,
      ( .FromPort | tostring ),
      ( .ToPort | tostring ),
      ( [ .IpRanges[] | .CidrIp ] | join(", ") ),
      ( [ .UserIdGroupPairs[] | .GroupId ] | join(" ") )
    ] | join( " ")
  ],
  "Egress": [
    .IpPermissionsEgress[] | [
      .IpProtocol,
      ( [ .IpRanges[] | .CidrIp ] | join(", ") )
    ] | join(" ")
  ]
}'
