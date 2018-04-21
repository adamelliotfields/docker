# `mongo-client`
> _Docker image running Ubuntu 16.04 with `mongodb-org-shell`, `mongodb-org-tools`, `mongo-hacker`, and `micro`._

This is a MongoDB development environment in a container. It can be used to interact with your existing MongoDB containers.

[`mongo-org-shell`](https://docs.mongodb.com/getting-started/shell/client) provides the familiar `mongo` command for command-line interactive with your database.

[`mongo-org-tools`](https://github.com/mongodb/mongo-tools) provide utilities for administering your database, like imports and exports.

[`mongo-hacker`](https://github.com/TylerBrock/mongo-hacker) is a collection of JavaScript files loaded by the `mongo` shell at startup that provide additional methods as well as pretty-printing JSON with syntax highlighting.

[`micro`](https://github.com/zyedidia/micro) is included as a powerful command-line text editor with syntax highlighting without needing to know Vim or Emacs.

### Supported tags and respective `Dockerfile` links
  - `latest`, `3.6.4` ([_Dockerfile_](https://github.com/adamelliotfields/docker/blob/master/mongo-client/Dockerfile))

### Usage

The entrypoint is `/bin/bash`.

```
docker run -it --rm adamelliotfields/mongo-client:latest

```

Once you have shell access, you can connect to the Mongo shell.

```
mongo --host 172.17.0.1 --port 27017

```

If you need to read/write from/to the host file system, use a bind mount.

```
docker run --volume /home/adam:/home/adam -it --rm adamelliotfields/mongo-client:latest

mongoexport --host 172.17.0.1 --port 27017 --db test --collection test --out /home/adam/test.json

```

If your Mongo server is a container connected to a user-defined network, you can use the container name instead of the IP address.

```
docker network create MONGO_NETWORK

docker volume create MONGO_DATA_VOLUME
docker volume create MONGO_CONFIG_VOLUME

docker run \
--name mongo \
--mount type=volume,src=MONGO_DATA_VOLUME,dst=/data/db \
--mount type=volume,src=MONGO_CONFIG_VOLUME,dst=/data/configdb \
--network MONGO_NETWORK \
--publish 27017:27017 \
--detach \
mongo:latest

docker run --network MONGO_NETWORK -it --rm adamelliotfields/mongo-client:latest

mongo --host mongo --port 27017

```
