 docker exec -it ucp-kv etcdctl \
  --endpoint https://127.0.0.1:2379 \
  --ca-file /etc/docker/ssl/ca.pem \
  --cert-file /etc/docker/ssl/cert.pem \
  --key-file /etc/docker/ssl/key.pem \
  cluster-health
