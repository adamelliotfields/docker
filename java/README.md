# Java
> _Ubuntu 16.04 with OpenJDK 8, Java REPL, Gradle, Micro, and Gotop._

Use this for Java development work, where you might need to `exec` into the container to edit a file or check resource utilization.

It can be used as a base for other Java-based containers, for example, running a local ZooKeeper server.

### Supported tags and respective `Dockerfile` links
  - `latest`, `8u162` ([_Dockerfile_](https://github.com/adamelliotfields/docker/blob/master/java/Dockerfile))

### Usage

The default command is `javarepl`, which can be overridden when starting the container.

By default, the container does not create any volumes or expose any ports.

```
docker run -it --rm adamelliotfields/java:latest
```
