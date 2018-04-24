FROM ubuntu:xenial

ENV EDITOR /usr/local/bin/micro
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Java REPL launcher script
COPY javarepl.sh /usr/local/bin/javarepl

# Global environmental variables
RUN set -e \
&& echo 'EDITOR=/usr/local/bin/micro' >> /etc/environment \
&& echo 'JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> /etc/environment

# Create unprivileged user and enable color prompt
RUN set -e \
&& adduser --disabled-password --gecos "" java \
&& sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' /home/java/.bashrc \
&& sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' /root/.bashrc

# Install OpenJDK and dependencies
# NOTE: wget recommends ca-certificates, which is required by ca-certificates-java
RUN JAVA_VERSION='8u162-b12-0ubuntu0.16.04.2'; \
set -e \
&& apt-get update \
&& apt-get install -y --no-install-recommends \
"openjdk-8-jdk=$JAVA_VERSION" \
ca-certificates-java \
java-common \
tar \
gzip \
wget \
unzip

# Java REPL
RUN JAVA_REPL_VERSION='428'; \
set -e \
&& mkdir -p "$JAVA_HOME/lib" \
&& wget --output-document "$JAVA_HOME/lib/javarepl.jar" --no-verbose "https://github.com/albertlatacz/java-repl/releases/download/428/javarepl-$JAVA_REPL_VERSION.jar" \
&& chown root:root /usr/local/bin/javarepl \
&& chmod +x /usr/local/bin/javarepl

# Gradle
RUN GRADLE_VERSION='4.7'; \
set -e \
&& wget --output-document gradle.zip --no-verbose "https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip" \
&& unzip -d /opt gradle.zip \
&& mv "/opt/gradle-$GRADLE_VERSION" /opt/gradle \
&& chmod +x /opt/gradle/bin/gradle \
&& ln -s /opt/gradle/bin/gradle /usr/local/bin/gradle \
&& rm gradle.zip

# Micro text editor
RUN MICRO_VERSION='1.4.0'; \
set -e \
&& wget --output-document micro.tar.gz --no-verbose "https://github.com/zyedidia/micro/releases/download/v$MICRO_VERSION/micro-$MICRO_VERSION-linux64.tar.gz" \
&& tar -xzf micro.tar.gz --directory /usr/local/bin \
&& mv "/usr/local/bin/micro-$MICRO_VERSION/micro" /usr/local/bin/micro \
&& chown root:root /usr/local/bin/micro \
&& chmod +x /usr/local/bin/micro \
&& rm micro.tar.gz \
&& rm -rf "/usr/local/bin/micro-$MICRO_VERSION"

# Gotop system monitor
# NOTE: use parameter expansion - ${} - because of the underscores in the URL
RUN GOTOP_VERSION='1.2.14'; \
set -e \
&& mkdir -p "/gotop-$GOTOP_VERSION" \
&& wget --output-document "/gotop-$GOTOP_VERSION/gotop.tgz" --no-verbose "https://github.com/cjbassi/gotop/releases/download/$GOTOP_VERSION/gotop_${GOTOP_VERSION}_linux_amd64.tgz" \
&& tar -C "/gotop-$GOTOP_VERSION" -xzf "/gotop-$GOTOP_VERSION/gotop.tgz" \
&& mv "/gotop-$GOTOP_VERSION/gotop" /usr/local/bin/gotop \
&& chown root:root /usr/local/bin/gotop \
&& chmod +x /usr/local/bin/gotop \
&& rm -rf "gotop-$GOTOP_VERSION"

# Cleanup
RUN set -e \
&& apt-get remove -y --purge --auto-remove wget unzip \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

CMD ["javarepl"]
