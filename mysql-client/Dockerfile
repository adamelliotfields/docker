FROM ubuntu:xenial

RUN KEY='A4A9406876FCBD3C456770C88C718D3B5072E1F5'; \
set -e \
&& export GNUPGHOME="$(mktemp -d)" \
&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$KEY" \
&& gpg --export "$KEY" > /etc/apt/trusted.gpg.d/mysql-tools.gpg \
&& rm -rf "$GNUPGHOME" \
&& apt-key list > /dev/null

RUN echo "deb [arch=amd64] http://repo.mysql.com/apt/ubuntu/ xenial mysql-tools" > /etc/apt/sources.list.d/mysql-tools.list

RUN apt-get update && apt-get install -y \
mysql-shell=8.0.11-1ubuntu16.04 \
mysql-utilities=1.6.5-1ubuntu16.04 \
sqlite3=3.11.0-1ubuntu1 \
wget

RUN ln -s /usr/bin/mysqlsh /usr/bin/mysql

RUN MICRO_VERSION='1.4.0'; \
set -e \
&& wget "https://github.com/zyedidia/micro/releases/download/v$MICRO_VERSION/micro-$MICRO_VERSION-linux64.tar.gz" --output-document "/usr/bin/micro-$MICRO_VERSION.tar.gz" --no-verbose \
&& tar -xzf "/usr/bin/micro-$MICRO_VERSION.tar.gz" --directory /usr/bin \
&& mv "/usr/bin/micro-$MICRO_VERSION/micro" /usr/bin/micro \
&& rm "/usr/bin/micro-$MICRO_VERSION.tar.gz" \
&& rm -rf "/usr/bin/micro-$MICRO_VERSION" \
&& chmod +x /usr/bin/micro

RUN apt-get remove --purge --auto-remove -y wget

WORKDIR /root

STOPSIGNAL SIGTERM

CMD ["mysql", "--sql"]
