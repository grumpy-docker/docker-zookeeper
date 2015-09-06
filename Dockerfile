FROM java:8-jre
MAINTAINER Alex Sherwin <alex.sherwin@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV ZK_VERSION=3.5.1-alpha

RUN wget -q http://apache.cs.utah.edu/zookeeper/zookeeper-${ZK_VERSION}/zookeeper-${ZK_VERSION}.tar.gz -O /tmp/zookeeper-${ZK_VERSION}.tar.gz && \
    tar xfz /tmp/zookeeper-${ZK_VERSION}.tar.gz -C / && \
    rm /tmp/zookeeper-${ZK_VERSION}.tar.gz

ADD entrypoint.sh /entrypoint.sh
ADD zoo.cfg /etc/zookeeper/zoo.cfg

RUN mv /zookeeper-${ZK_VERSION} /zookeeper && chmod +x /entrypoint.sh

EXPOSE 2181 2888 3888

CMD ["/entrypoint.sh"]

VOLUME /data
VOLUME /datalog
