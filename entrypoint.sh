#!/bin/sh

echo "Checking pre-conditions..."

if [ -z "${ZK_MYID}" ]; then
    echo "Missing required environment variable ZK_MYID"
    exit 1
fi

if [ -z "${ZK_SERVER1}" ]; then
    echo "Must have at least two ZooKeeper servers set, i.e. environment variable ZK_SERVER1 and ZK_SERVER2"
    exit 1
fi

if [ -z "${ZK_SERVER2}" ]; then
    echo "Must have at least two ZooKeeper servers set, i.e. environment variable ZK_SERVER1 and ZK_SERVER2"
    exit 1
fi

echo "Setting /data/myid to ${ZK_MYID}"
echo ${ZK_MYID} >> /data/myid

echo "Setting up /etc/zookeeper/zoo.cfg servers based on environment variables..."

if [ ! -z "${ZK_BIND_ADDRESS}" ]; then
    echo "ZK_BIND_ADDRESS: ${ZK_BIND_ADDRESS}"
    sed -r -i "s/#(clientPortAddress)=.*/\1=${ZK_BIND_ADDRESS}/g" /etc/zookeeper/zoo.cfg
fi

if [ ! -z "${ZK_CLIENT_PORT}" ]; then
    echo "ZK_CLIENT_PORT: ${ZK_CLIENT_PORT}"
    sed -r -i "s/(clientPort)=.*/\1=${ZK_CLIENT_PORT}/g" /etc/zookeeper/zoo.cfg
fi

if [ ! -z "${ZK_SERVER1}" ]; then
    echo "ZooKeeper Server 1: ${ZK_SERVER1}"
    sed -r -i "s/#(server\.1)=FIXME(:2888:3888)/\1=${ZK_SERVER1}\2/g" /etc/zookeeper/zoo.cfg
fi

if [ ! -z "${ZK_SERVER2}" ]; then
    echo "ZooKeeper Server 2: ${ZK_SERVER2}"
    sed -r -i "s/#(server\.2)=FIXME(:2888:3888)/\1=${ZK_SERVER2}\2/g" /etc/zookeeper/zoo.cfg
fi

if [ ! -z "${ZK_SERVER3}" ]; then
    echo "ZooKeeper Server 3: ${ZK_SERVER3}"
    sed -r -i "s/#(server\.3)=FIXME(:2888:3888)/\1=${ZK_SERVER3}\2/g" /etc/zookeeper/zoo.cfg
fi

if [ ! -z "${ZK_SERVER4}" ]; then
    echo "ZooKeeper Server 4: ${ZK_SERVER4}"
    sed -r -i "s/#(server\.4)=FIXME(:2888:3888)/\1=${ZK_SERVER4}\2/g" /etc/zookeeper/zoo.cfg
fi

if [ ! -z "${ZK_SERVER5}" ]; then
    echo "ZooKeeper Server 5: ${ZK_SERVER5}"
    sed -r -i "s/#(server\.5)=FIXME(:2888:3888)/\1=${ZK_SERVER5}\2/g" /etc/zookeeper/zoo.cfg
fi

if [ ! -z "${ZK_SERVER6}" ]; then
    echo "ZooKeeper Server 6: ${ZK_SERVER6}"
    sed -r -i "s/#(server\.6)=FIXME(:2888:3888)/\1=${ZK_SERVER6}\2/g" /etc/zookeeper/zoo.cfg
fi

if [ ! -z "${ZK_SERVER7}" ]; then
    echo "ZooKeeper Server 7: ${ZK_SERVER7}"
    sed -r -i "s/#(server\.7)=FIXME(:2888:3888)/\1=${ZK_SERVER7}\2/g" /etc/zookeeper/zoo.cfg
fi

if [ ! -z "${ZK_SERVER8}" ]; then
    echo "ZooKeeper Server 8: ${ZK_SERVER8}"
    sed -r -i "s/#(server\.8)=FIXME(:2888:3888)/\1=${ZK_SERVER8}\2/g" /etc/zookeeper/zoo.cfg
fi

if [ ! -z "${ZK_SERVER9}" ]; then
    echo "ZooKeeper Server 9: ${ZK_SERVER9}"
    sed -r -i "s/#(server\.9)=FIXME/\1=${ZK_SERVER9}\2/g" /etc/zookeeper/zoo.cfg
fi

echo "==== START /etc/zookeeper/zoo.cfg ===="
cat /etc/zookeeper/zoo.cfg
echo "==== END /etc/zookeeper/zoo.cfg ===="

CMD="/zookeeper/bin/zkServer.sh start-foreground /etc/zookeeper/zoo.cfg"

echo "Starting ZooKeeper [${ZK_VERSION}] using command [${CMD}]"
$CMD
