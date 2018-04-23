FROM ubuntu:artful

ADD https://raw.githubusercontent.com/docker-library/docker/master/18.04/modprobe.sh /usr/local/bin/modprobe

ADD https://raw.githubusercontent.com/docker/docker/master/hack/dind /usr/local/bin/dind

ADD https://raw.githubusercontent.com/docker-library/docker/master/18.04/dind/dockerd-entrypoint.sh /usr/local/bin/entrypoint.sh

ADD https://github.com/krallin/tini/releases/download/v0.18.0/tini-static-amd64 /usr/local/bin/tini

ADD https://github.com/bcicen/ctop/releases/download/v0.7.1/ctop-0.7.1-linux-amd64 /usr/local/bin/ctop

RUN chmod +x \
/usr/local/bin/modprobe \
/usr/local/bin/dind \
/usr/local/bin/entrypoint.sh \
/usr/local/bin/tini \
/usr/local/bin/ctop

# https://github.com/docker-library/docker/blob/master/18.04/Dockerfile#L10
RUN echo 'hosts: files dns' > /etc/nsswitch.conf

# https://github.com/docker-library/docker/blob/master/18.04/dind/Dockerfile#L25
RUN set -e \
&& adduser --system --group --no-create-home dockremap \
&& echo 'dockremap:165536:65536' >> /etc/subuid \
&& echo 'dockremap:165536:65536' >> /etc/subgid

RUN set -e \
&& adduser --disabled-password --gecos "" docker \
&& sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' /home/docker/.bashrc \
&& sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' /root/.bashrc

RUN set -e && apt-get update && apt-get install -y --no-install-recommends \
ca-certificates \
iptables \
iproute2 \
linux-image-4.13.0-38-generic \
apt-transport-https \
tar \
gzip \
wget \
curl

RUN MICRO_VERSION='1.4.0'; \
set -e \
&& wget --output-document micro.tar.gz --no-verbose "https://github.com/zyedidia/micro/releases/download/v$MICRO_VERSION/micro-$MICRO_VERSION-linux64.tar.gz" \
&& tar -xzf micro.tar.gz --directory /usr/local/bin \
&& mv "/usr/local/bin/micro-$MICRO_VERSION/micro" /usr/local/bin/micro \
&& chmod +x /usr/local/bin/micro \
&& chown root:root /usr/local/bin/micro \
&& rm micro.tar.gz \
&& rm -rf "/usr/local/bin/micro-$MICRO_VERSION"

RUN DOCKER_VERSION='18.04.0~ce~3-0~ubuntu'; \
set -e \
&& curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
&& touch /etc/apt/sources.list.d/docker-ce.list \
&& echo 'deb [arch=amd64] https://download.docker.com/linux/ubuntu artful edge' > /etc/apt/sources.list.d/docker-ce.list \
&& apt-get update \
&& apt-get install -y --no-install-recommends "docker-ce=$DOCKER_VERSION"

RUN set -e \
&& apt-get remove -y --purge --auto-remove wget curl \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

VOLUME /var/lib/docker

# https://docs.docker.com/engine/swarm/swarm-tutorial/#open-protocols-and-ports-between-the-hosts
EXPOSE 2375/tcp 2377/tcp 7946/tcp
EXPOSE 4789/udp 7946/udp

# Pass the --storage-driver flag when running the container:
#   docker run adamelliotfields/docker --storage-driver overlay2
# The storage driver must match the host:
#   docker info | grep 'Storage Driver'
ENTRYPOINT ["tini", "--", "entrypoint.sh"]
