#!/bin/bash

set -x

# extract snapshot jar
cd /home/maxgraph

# depends on hadoop
export HADOOP_USER_NAME=admin

# start app
JAVA_OPT="-server -Xmx1024m -Xms1024m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=./java.hprof -verbose:gc -Xloggc:./gc.log -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintHeapAtGC -XX:+PrintTenuringDistribution -Djava.awt.headless=true -Dsun.net.client.defaultConnectTimeout=10000 -Dsun.net.client.defaultReadTimeout=30000 -XX:+DisableExplicitGC -XX:-OmitStackTraceInFastThrow -XX:+UseG1GC -XX:InitiatingHeapOccupancyPercent=75 -Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8 -Dlogfilename=./logs/maxgraph-coordinator.log -Dlogbasedir=/home/maxgraph/logs/ -Dlog4j.configurationFile=file:./log4j2.xml -classpath ./*:"

cd /home/maxgraph
mkdir -p /home/maxgraph/logs

inner_config=/home/maxgraph/standalone.properties
/usr/local/jdk1.8.0_191/bin/java ${JAVA_OPT} com.alibaba.graphscopetest.k8s.LogWriterMain $inner_config  1>./logs/maxgraph-coordinator.out 2>./logs/maxgraph-coordinator.err