aws --out text --region us-east-2 ec2 describe-vpcs --filters
Name=tag:Name,Values=DNU_vpc --query 'Vpcs[0].VpcId'

echo $instance_id | xargs -n 1  aws --out table --region us-east-2 ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,PrivateDnsName,PublicDnsName]' --instance-id

#ELB
##query lbs
aws --out json --region us-east-2 elb describe-load-balancers --query 'LoadBalancerDescriptions[*].DNSName' | jq -r '.[]'
##register instances
aws --region us-east-2 elb register-instances-with-load-balancer
--load-balancer-name nks-tst-extralb --instances
##query registered instances
aws --out json --region us-east-2 elb describe-load-balancers --load-balancer-name nks-tst-extralb --query 'LoadBalancerDescriptions[*].Instances[*].InstanceId'

#EC2
aws --region us-east-1 --out table ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,PrivateDnsName,PublicDnsName,Tags[?Key==`Name`].Value]'
###query instances
aws --out table --region us-east-2 ec2 describe-instances --filters
Name=instance-state-name,Values=running,
##stack
Name=tag:product,Values=nekso,Name=tag:aws:cloudformation:stack-name,Values=nks-tst
##managers
,Name=tag:swarm-node-type,Values=manager
##workers
,Name=tag:swarm-node-type,Values=worker
##dnsnames
--query 'Reservations[*].Instances[*].[InstanceId,PrivateDnsName,PublicDnsName]'
##tags
--query 'Reservations[*].Instances[*].[InstanceId,Tags[*]]'
##instance ids
--query 'Reservations[*].Instances[*].InstanceId' | jq -rc '. | map(.[0]) |
join(" ")'

#Cloudformation
#status
aws --out json --region us-east-2 cloudformation describe-stacks --stack-name nks-tst | jq '.Stacks[0].StackStatus'
#delete
aws --region=us-east-2 cloudformation delete-stack --stack-name nks-tst

#Route53
#id by name
aws --out json route53 list-hosted-zones | jq -r '.HostedZones[] | select(.Name=="nekso.io.") | .Id' | cut -d'/' -f3
aws --out json route53 get-hosted-zone --id $()

aws --out json --region us-east-2 elb describe-load-balancers | jq -r '.LoadBalancerDescriptions[] | select( .LoadBalancerName | test ("^nks-tst-.*")) | .DNSName, .CanonicalHostedZoneNameID'

#Stack Outputs
aws --out json --region us-east-2 cloudformation describe-stacks --stack-name "stack_name" | jq '.Stacks[0].Outputs'

#Filtered SGs
aws --out json --region us-east-2 ec2 describe-security-groups --filter 'Name=tag:aws:cloudformation:stack-name,Values=nks-tst,Name=tag:aws:cloudformation:logical-id,Values=UCPLoadBalancerSG' --query 'SecurityGroups[0].GroupId'
aws --out json --region us-east-2 ec2 describe-security-groups --filter 'Name=tag:aws:cloudformation:stack-name,Values=nks-tst,Name=tag:aws:cloudformation:logical-id,Values=DTRLoadBalancerSG' --query 'SecurityGroups[0].GroupId'
aws --out json --region us-east-2 ec2 describe-security-groups --filter 'Name=tag:aws:cloudformation:stack-name,Values=nks-tst,Name=tag:aws:cloudformation:logical-id,Values=ExternalLoadBalancerSG' --query 'SecurityGroups[0].GroupId'
aws --out json --region us-east-2 ec2 describe-security-groups --filter 'Name=tag:aws:cloudformation:stack-name,Values=nks-tst,Name=tag:aws:cloudformation:logical-id,Values=*LoadBalancerSG' --query 'SecurityGroups[0].GroupId'
