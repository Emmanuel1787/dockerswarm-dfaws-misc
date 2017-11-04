. ./env.sh
aws --out json elb describe-load-balancers \
  | jq -cr ".LoadBalancerDescriptions[] | select( .LoadBalancerName | test (\"^${STACK_NAME}-.*\") ) | .DNSName"
