FROM ubuntu:xenial

RUN apt-get update \
&& apt-get install -y wget apt-transport-https unzip make

# Micro
RUN MICRO_VERSION='1.4.0'; \
set -e \
&& wget "https://github.com/zyedidia/micro/releases/download/v$MICRO_VERSION/micro-$MICRO_VERSION-linux64.tar.gz" --output-document "/usr/bin/micro-$MICRO_VERSION.tar.gz" --no-verbose \
&& tar -xzf "/usr/bin/micro-$MICRO_VERSION.tar.gz" --directory /usr/bin \
&& mv "/usr/bin/micro-$MICRO_VERSION/micro" /usr/bin/micro \
&& rm "/usr/bin/micro-$MICRO_VERSION.tar.gz" \
&& rm -rf "/usr/bin/micro-$MICRO_VERSION" \
&& chmod +x /usr/bin/micro

# Mongo
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5

RUN echo "deb [arch=amd64] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list

RUN apt-get update && apt-get install -y \
mongodb-org-shell=3.6.4 \
mongodb-org-tools=3.6.4

# mongo-hacker
RUN set -e \
&& wget https://github.com/TylerBrock/mongo-hacker/archive/master.zip --output-document /root/mongo-hacker.zip \
&& unzip /root/mongo-hacker.zip -d /root \
&& mv /root/mongo-hacker-master /root/mongo-hacker \
&& make install -C /root/mongo-hacker \
&& rm mongo-hacker.zip

RUN apt-get remove --purge --auto-remove -y wget apt-transport-https unzip make

WORKDIR /root

STOPSIGNAL SIGTERM

CMD ["/bin/bash"]
