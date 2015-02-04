#!/bin/bash -x

# This file should be placed inside mesos scheduler marathon app archive for cassandra (cassandra-mesos-2.0.9-2.tgz),
# into archive /bin directory
#

sed -e "s/<ZK_HOSTS>/$1/" \
    -e "s/<CASSANDRA_NODES_COUNT>/$2/" \
    -e "s/<CPUS_RES_REQ>/$3/" \
    -e "s/<MEM_RES_REQ>/$4/" \
    -e "s/<DISK_RES_REQ>/$5/" \
    -e "s/<CONF_SERVER_HOSTNAME>/$6/" \
    -e "s/<CONF_SERVER_PORT>/$7/" \
    -e "s/<CONF_SERVER_INTERNAL_PORT>/$8/" \
    ./cassandra-mesos-2.0.9-2/conf/mesos.yaml.tmpl > ./cassandra-mesos-2.0.9-2/conf/mesos.yaml

sed -e "s,<CLUSTER_NAME>,$9," -e "s,<WORK_DIR>,${10}," ./cassandra-mesos-2.0.9-2/conf/cassandra.yaml.tmpl > ./cassandra-mesos-2.0.9-2/conf/cassandra.yaml
sed -i -e "s/GRAPHITE_PREFIX/collectd.`hostname | tr '.' '_'`.cassandra/" ./cassandra-mesos-2.0.9-2/conf/metrics-reporter-graphite.yaml


cd cassandra-mesos-2.0.9-2
./bin/cassandra-mesos
