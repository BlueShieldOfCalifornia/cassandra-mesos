#!/bin/bash 

# Our cassandra-mesos project version follows the Cassandra version number
PROJVERSION=$(mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate -Dexpression=project.version | grep -v '\[')
CASSVERSION=$(mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate -Dexpression=cassandra.version | grep -v '\[')

echo Building Cassandra $CASSVERSION for Mesos

# Create our jar so we can package it up as well. Do this first, so we can fail fast
mvn clean package

rm -r cassandra-mesos-*
wget http://archive.apache.org/dist/cassandra/${CASSVERSION}/apache-cassandra-${CASSVERSION}-bin.tar.gz

tar xzf apache-cassandra*.tar.gz
rm apache-cassandra*tar.gz

mv apache-cassandra* cassandra-mesos-${PROJVERSION}

cp bin/cassandra-mesos cassandra-mesos-${PROJVERSION}/bin
chmod u+x cassandra-mesos-${PROJVERSION}/bin/cassandra-mesos

cp bin/run_cassandra.sh cassandra-mesos-${PROJVERSION}/bin
chmod u+x cassandra-mesos-${PROJVERSION}/bin/run_cassandra.sh

wget http://central.maven.org/maven2/com/yammer/metrics/metrics-graphite/2.2.0/metrics-graphite-2.2.0.jar
cp metrics-graphite-2.2.0.jar cassandra-mesos-${PROJVERSION}/lib/

cp conf/* cassandra-mesos-${PROJVERSION}/conf
cp target/*.jar cassandra-mesos*/lib

tar czf cassandra-mesos-${PROJVERSION}.tgz cassandra-mesos-${PROJVERSION}


