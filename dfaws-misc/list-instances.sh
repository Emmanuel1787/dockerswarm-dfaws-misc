#!/bin/bash
. ./env.sh
set -o nounset

aws --out json --region ${AWS_DEFAULT_REGION} ec2 describe-instances \
  --filter Name=vpc-id,Values=$(./get-vpc.sh) \
  | jq ".Reservations[] | .Instances[0] | {
    InstanceId,\
    ImageId,\
    State:(.State.Name),\
    PrivateDnsName,\
    PublicDnsName,\
    KeyName,\
    InstanceType,\
    AZ:(.Placement.AvailabilityZone),\
    VpcId,\
    SubnetId,\
    Tags:(.Tags | from_entries),\
    SecurityGroups\
  }"

