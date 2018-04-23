# Docker
> _Docker image running Ubuntu 17.10 with Docker-in-Docker_

This image can be used to set up a Docker Swarm locally, or any other situation where you'd want to run Docker containers inside a Docker container.

`micro` and `ctop` are included for convenience. If your terminal appears blank after running one of them, try resizing it.

### Supported tags and respective `Dockerfile` links
  - `latest`, `18.04.0` ([_Dockerfile_](https://github.com/adamelliotfields/docker/blob/master/docker/Dockerfile))

### Usage

```bash
docker volume create DOCKER

docker run \
--name docker \
--mount type=volume,src=DOCKER,dst=/var/lib/docker \
--privileged \
--detach \
adamelliotfields/docker:latest --storage-driver overlay2
```

### Swarm

Here is a sample `docker-compose` file that sets up a 3 node Swarm (1 manager, 2 workers).

Port 80 on the manager node will be bound to the host.

```yaml
version: "3.2"

services:
  swarm_manager:
    container_name: swarm-manager
    image: adamelliotfields/docker:18.04.0
    privileged: true
    entrypoint:
      - entrypoint.sh
      - --storage-driver=overlay2
    ports:
      - "80:80"
    expose:
      - "2375"
      - "2377"
      - "7946/tcp"
      - "7946/udp"
      - "4789/udp"
    networks:
      - SWARM
    volumes:
      - type: volume
        source: SWARM_MANAGER
        target: /var/lib/docker
  swarm_worker_1:
    container_name: swarm-worker-1
    image: adamelliotfields/docker:18.04.0
    privileged: true
    depends_on:
      - swarm_manager
    entrypoint:
      - entrypoint.sh
      - --storage-driver=overlay2
    expose:
      - "2375"
      - "2377"
      - "7946/tcp"
      - "7946/udp"
      - "4789/udp"
    networks:
      - SWARM
    volumes:
      - type: volume
        source: SWARM_WORKER_1
        target: /var/lib/docker
  swarm_worker_2:
    container_name: swarm-worker-2
    image: adamelliotfields/docker:18.04.0
    privileged: true
    depends_on:
      - swarm_worker_1
    entrypoint:
      - entrypoint.sh
      - --storage-driver=overlay2
    expose:
      - "2375"
      - "2377"
      - "7946/tcp"
      - "7946/udp"
      - "4789/udp"
    networks:
      - SWARM
    volumes:
      - type: volume
        source: SWARM_WORKER_2
        target: /var/lib/docker

# docker network create SWARM
networks:
  SWARM:
    external: true

# docker volume create SWARM_MANAGER
# docker volume create SWARM_WORKER_1
# docker volume create SWARM_WORKER_2
volumes:
  SWARM_MANAGER:
    external: true
  SWARM_WORKER_1:
    external: true
  SWARM_WORKER_2:
    external: true
```
