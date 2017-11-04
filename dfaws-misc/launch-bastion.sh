instance_id=$(aws --region us-east-2 ec2 run-instances \
  --image-id ami-33ab8f56 \
  --count 1 \
  --instance-type t2.micro \
  --key-name jorge.arrieta@blanclink.com \
  --security-group-ids sg-b5659bdc \
  --subnet-id subnet-e426d98d \
  --query 'Instances[0].InstanceId' \
  --output text)

echo $instance_id | xargs -n 1  aws --out table --region us-east-2 ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,PrivateDnsName,PublicDnsName]' --instance-id
