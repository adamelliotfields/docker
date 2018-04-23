FROM ubuntu:xenial

ARG DEBIAN_FRONTEND=noninteractive

COPY ./daemon.json /etc/docker/daemon.json

COPY ./10-docker.conf /etc/systemd/system/docker.service.d/10-docker.conf

COPY ./10-kubeadm.conf /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

COPY ./kubeadm-init.sh /usr/local/bin/kubeadm-init.sh

RUN chmod +x /usr/local/bin/kubeadm-init-master.sh

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
systemd \
apt-transport-https \
tar \
gzip \
wget \
curl

RUN CRICTL_VERSION='1.0.0-beta.0'; \
set -e \
&& wget --output-document crictl.tar.gz --no-verbose "https://github.com/kubernetes-incubator/cri-tools/releases/download/v1.0.0-beta.0/crictl-v$CRICTL_VERSION-linux-amd64.tar.gz" \
&& tar -xzf crictl.tar.gz --directory /usr/local/bin \
&& chmod +x /usr/local/bin/crictl \
&& rm crictl.tar.gz

RUN DOCKER_VERSION='17.03.0~ce-0~ubuntu-xenial'; \
set -e \
&& curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
&& touch /etc/apt/sources.list.d/docker-ce.list \
&& echo 'deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable' > /etc/apt/sources.list.d/docker-ce.list \
&& apt-get update \
&& apt-get install -y --no-install-recommends docker-ce="$DOCKER_VERSION"

RUN K8S_VERSION='1.10.1-00'; \
set -e \
&& curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
&& touch /etc/apt/sources.list.d/kubernetes.list \
&& echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list \
&& apt-get update \
&& apt-get -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' install -y --no-install-recommends kubeadm="$K8S_VERSION" kubectl="$K8S_VERSION" kubelet="$K8S_VERSION"

RUN set -e \
&& apt-get remove -y --purge --auto-remove wget curl \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

VOLUME /var/lib/docker
VOLUME /etc/kubernetes

EXPOSE 2375/tcp

ENTRYPOINT ["init"]
