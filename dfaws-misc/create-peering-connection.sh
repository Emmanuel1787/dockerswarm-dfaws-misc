#!/bin/bash
. ./env.sh
set -o nounset

aws --out json ec2 create-vpc-peering-connection \
  --vpc-id $(VPC_NAME="${ASSOCIATED_VPC}" ./get-vpc.sh) \
  --peer-vpc-id $(VPC_NAME="${STACK_NAME}-VPC" ./get-vpc.sh) \
  | jq -r '.VpcPeeringConnection.VpcPeeringConnectionId' \
  | xargs -r aws --out json ec2 accept-vpc-peering-connection --vpc-peering-connection-id
