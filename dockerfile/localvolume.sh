#!/bin/bash
set -x

containerid=`echo ${pouch_container_id}|cut -c1-12`
logdir=${POD_WORK_ROOT_DIR}/${POD_NAMESPACE}/${POD_NAME}/$containerid

# extract snapshot jar
cd /home/maxgraph

# depends on hadoop
export HADOOP_USER_NAME=admin

# start app
JAVA_OPT="-server -Xmx1024m -Xms1024m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=./java.hprof -verbose:gc -Xloggc:./gc.log -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintHeapAtGC -XX:+PrintTenuringDistribution -Djava.awt.headless=true -Dsun.net.client.defaultConnectTimeout=10000 -Dsun.net.client.defaultReadTimeout=30000 -XX:+DisableExplicitGC -XX:-OmitStackTraceInFastThrow -XX:+UseG1GC -XX:InitiatingHeapOccupancyPercent=75 -Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8 -Dlogfilename=$logdir/logs/maxgraph-coordinator.log -Dlogbasedir=$logdir/logs/ -Dlog4j.configurationFile=file:./log4j2.xml -classpath ./*:"

cd /home/maxgraph
mkdir -p $logdir/logs

inner_config=/home/maxgraph/standalone.properties
/usr/local/jdk1.8.0_191/bin/java ${JAVA_OPT} com.alibaba.graphscopetest.k8s.LocalVolumeMain $inner_config  1>$logdir/logs/maxgraph-coordinator.out 2>$logdir/logs/maxgraph-coordinator.err