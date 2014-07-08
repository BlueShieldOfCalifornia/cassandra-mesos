#!/bin/bash

# This file should be placed inside mesos scheduler marathon app archive for cassandra (cassandra-mesos-2.0.9-2.tar.gz),
# into archive /bin directory
#

sed -e "s/<ZK_HOSTS>/$1/" -e "s/<CASSANDRA_NODES_COUNT>/$2/"  -e "s/<CPUS_RES_REQ>/$3/" -e "s/<MEM_RES_REQ>/$4/" -e "s/<DISK_RES_REQ>/$5/" ./cassandra-mesos-2.0.9-2/conf/mesos.yaml.tmpl > ./cassandra-mesos-2.0.9-2/conf/mesos.yaml
cd cassandra-mesos-2.0.9-2
./bin/cassandra-mesos
