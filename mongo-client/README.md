# `mongo-client`

Docker image running Ubuntu 16.04, `mongodb-org-shell`, and `mongodb-org-tools`.

### Usage

The entrypoint is `/bin/bash`.

```bash
docker run -it --rm adamelliotfields/mongo-client:latest
```

Once you have shell access, you can connect to the Mongo shell.

```bash
# Connect to the Mongo shell
mongo --host 172.17.0.1 --port 27017
```

If you need to read/write from/to the host file system, use a bind mount.

```bash
docker run --volume /home/adam:/home/adam -it --rm adamelliotfields/mongo-client:latest

# Export a JSON file
mongoexport --host 172.17.0.1 --port 27017 --db test --collection test --out /home/adam/test.json
```

If your Mongo server is a container connected to a user-defined network, you can use the container
name instead of the IP address.

```bash
# Create a user-defined network
docker network create MONGO_NETWORK

# Create Mongo persistent volumes
docker volume create MONGO_DATA_VOLUME
docker volume create MONGO_CONFIG_VOLUME

# Deploy the official Mongo container
docker run \
--name mongo \
--mount type=volume,src=MONGO_DATA_VOLUME,dst=/data/db \
--mount type=volume,src=MONGO_CONFIG_VOLUME,dst=/data/configdb \
--network MONGO_NETWORK \
--publish 27017:27017 \
--detach \
mongo:latest

# Start the mongo-client container
docker run --network MONGO_NETWORK -it --rm adamelliotfields/mongo-client:latest

# Connect to the database server
mongo --host mongo --port 27017
```
