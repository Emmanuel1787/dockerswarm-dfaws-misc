# NODE_ADDRESS will be the IP address of this Docker Swarm manager node
NODE_ADDRESS=$(docker info --format '{{.Swarm.NodeAddr}}')
# VERSION will be your most recent version of the docker/ucp-auth image
VERSION=$(docker image ls --format '{{.Tag}}' docker/ucp-auth | head -n 1)
# This command will output detailed status of all servers and database tables
# in the RethinkDB cluster.
docker run --rm -v ucp-auth-store-certs:/tls docker/ucp-auth:${VERSION} --db-addr=${NODE_ADDRESS}:12383 db-status
