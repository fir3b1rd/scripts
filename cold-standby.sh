#!/bin/bash

#kill running instance
ps -ef | grep quickstar[t] | awk '{print $2}' | xargs kill
sleep 5
ps -ef | grep quickstar[t] | awk '{print $2}' | xargs kill
#check for runnings instances

 if  ps -ef |grep quickstar[t] -q; then
 	echo "please stop running quickstart"
 	exit 1
 fi

#clean up old installation files
rm -rf workingdir/*

#install cq master (start cq with nohup and in a subshell)
mkdir workingdir/master
cp files/cq-quickstart*.jar workingdir/master/.
cp files/license.properties workingdir/master/.
(cd workingdir/master && nohup java -jar cq-quickstart*.jar &)
sleep 300

#upload and start tarmk failover bundle 1.1.1
curl -u admin:admin -F action=install -F bundlestartlevel=20 -F bundlefile=@"files/oak-tarmk-failover-1.1.1.jar" http://localhost:4502/system/console/bundles
sleep 2
curl -u admin:admin http://localhost:4502/system/console/bundles/org.apache.jackrabbit.oak-tarmk-failover -F action=start
#shut down cq master
#create a install folder under crx-quickstart
#copy whole instance to a slave directory
#add the config files to the master instance
#add the config files to the slave instance
#start master instance
#start slave instance
#verify setup
#add some content on master
#stop master
#stop slave
#change slave to master and start the instance
#remove the slave config 
#verify the instance