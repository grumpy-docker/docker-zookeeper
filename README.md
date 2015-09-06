### Dockerized ZooKeeper

This Docker image is designed to be parameterized via environment variables to specify each ZooKeeper ensemble member's hostname, and is always assumed that the following ports are used for *every member*:

* 2181 - client port)
* 2888 & 3888 - ZooKeeper server ports

The examples to follow work on a local machine assuming the use of an overlay network with DNS available

zookeeper-3.5.1-alpha is used specifically to include the patches for https://issues.apache.org/jira/browse/ZOOKEEPER-1506, which fixes DNS re-resolution of nodes that leave/enter the ZooKeeper cluster whose IP changes but hostname remains the same.  This happens often when using an overlay network such as https://github.com/weaveworks/weave

The zoo.cfg included supports up to 9 parameterized ensemble members

### Requirements

The `ZK_MYID` and at least two `ZK_SERVER[X]` environment variables must be set

### Example

Run a 3 node ensemble
```
weave run -dt --name=zoo1 -e ZK_MYID=1 -e ZK_SERVER1=zoo1 -e ZK_SERVER2=zoo2 -e ZK_SERVER3=zoo3 zk
weave run -dt --name=zoo2 -e ZK_MYID=2 -e ZK_SERVER1=zoo1 -e ZK_SERVER2=zoo2 -e ZK_SERVER3=zoo3 zk
weave run -dt --name=zoo3 -e ZK_MYID=3 -e ZK_SERVER1=zoo1 -e ZK_SERVER2=zoo2 -e ZK_SERVER3=zoo3 zk
```

Run the [Four Letter Words](https://zookeeper.apache.org/doc/r3.4.6/zookeeperAdmin.html#sc_zkCommands)

```
weave run -it --rm busybox sh -c 'echo stat | nc zoo1 2181'
```

### Runtime
The default `/entrypoint.sh` will look for `ZK_MYID` and `ZK_SERVER[X]` environment variables and dynamically setup `/data/myid` and `/etc/zookeeper/zoo.cfg`, before running

```
/zookeeper/bin/zkServer.sh start-foreground /etc/zookeeper/zoo.cfg
```

### Ports

`2181` Client port

`2888` Quorum port

`3888` Leader election port

### Volumes

`/data` is the ZooKeeper `dataDir` volume

`/datalog` is the ZooKeeper `dataLogDir` volume
