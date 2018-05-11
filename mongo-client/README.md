# `mongo-client`
> _Docker image running Ubuntu 16.04 with `mongodb-org-shell`, `mongodb-org-tools`, `mongo-hacker`, and `micro`._

This is a MongoDB development environment in a container. It can be used to interact with your existing MongoDB containers.

[`mongo-org-shell`](https://docs.mongodb.com/getting-started/shell/client) provides the familiar `mongo` command for command-line interaction with your database.

[`mongo-org-tools`](https://github.com/mongodb/mongo-tools) provide utilities for administering your database, like imports and exports.

[`mongo-hacker`](https://github.com/TylerBrock/mongo-hacker) is a collection of JavaScript files loaded by the `mongo` shell at startup that provide additional methods as well as pretty-printing JSON with syntax highlighting.

[`micro`](https://github.com/zyedidia/micro) is included as a powerful command-line text editor with syntax highlighting without needing to know Vim or Emacs.

### Supported tags and respective `Dockerfile` links
  - `latest`, `3.6.4` ([Dockerfile](https://github.com/adamelliotfields/docker/blob/master/mongo-client/Dockerfile))

### Usage

For more examples, view the `README` in the [repo](https://github.com/adamelliotfields/docker/blob/master/mongo-client/README.md).

```
docker run -it --rm adamelliotfields/mongo-client:latest
```

Once you have shell access, you can connect to the Mongo CLI. You can get the container IP using `docker inspect`.

```bash
mongo --host 172.17.0.1 --port 27017
```

If you need to read/write from/to the host file system, use a bind mount. In this example, `test` is an imaginary database and collection.

```bash
docker run --volume /home/adam:/home/adam -it --rm adamelliotfields/mongo-client:latest

mongoexport --host 172.17.0.1 --port 27017 --db test --collection test --out /home/adam/test.json
```

If your Mongo server is a container connected to a user-defined network, you can use the container name instead of the IP address.

```bash
# Create network
docker network create MONGO

# Create volumes
docker volume create MONGO_DB
docker volume create MONGO_CONFIGDB

# Run the container
docker run \
--name mongo \
--mount type=volume,src=MONGO_DB,dst=/data/db \
--mount type=volume,src=MONGO_CONFIGDB,dst=/data/configdb \
--network MONGO \
--publish 27017:27017 \
--detach \
mongo:latest

# Run mongo-client interactively
docker run --network MONGO -it --rm adamelliotfields/mongo-client:latest

# Connect to the mongo server
mongo --host mongo --port 27017
```
