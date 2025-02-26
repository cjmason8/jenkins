FROM jenkins/jenkins:jdk21

USER root

# install prerequisite debian packages
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
     maven \
     apt-transport-https \
     software-properties-common \
     vim \
     wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# install gosu for a better su+exec command
ARG GOSU_VERSION=1.10
RUN dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
 && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
 && chmod +x /usr/local/bin/gosu \
 && gosu nobody true 

 RUN apt-get update && apt-get install -y \
 ca-certificates curl gnupg && \
 mkdir -p /etc/apt/keyrings && \
 curl -fsSL https://download.docker.com/linux/debian/gpg | tee /etc/apt/keyrings/docker.asc > /dev/null && \
 chmod a+r /etc/apt/keyrings/docker.asc && \
 echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list && \
 apt-get update && apt-get install -y docker-ce-cli && \
 rm -rf /var/lib/apt/lists/*

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    docker-ce-cli \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && groupadd -g 1002 docker \
 && usermod -aG docker jenkins \
 && mkdir /home/tomcat \
 && chmod 777 /home/tomcat

COPY rancher-compose /usr/local/bin

USER jenkins
