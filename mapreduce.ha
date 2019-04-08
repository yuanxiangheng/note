core-site.xml
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://node01:9000</value>
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/var/sxt/hadoop/local</value>
    </property>
hdfs-site.xml
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
    <property>
        <name>dfs.namenode.secondary.http-address</name>
        <value>node01:50090</value>
    </property>
slaves
	node01
**************************************************

core-site.xml
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://node01:9000</value>
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/var/sxt/hadoop/full</value>
    </property>
hdfs-site.xml
    <property>
        <name>dfs.replication</name>
        <value>3</value>
    </property>
    <property>
        <name>dfs.namenode.secondary.http-address</name>
        <value>node02:50090</value>
    </property>
slaves
     node02
     node03
     node04


**************************************************

*-env.sh
core-site.xml
<property>
        <name>fs.defaultFS</name>
        <value>hdfs://node01:9000</value>
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/var/sxt/hadoop-2.6.5</value>
    </property>
hdfs-site.xml
<property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
hdfs namenode -format
start-dfs.sh
hdfs dfs -D dfs.blocksize=1048576 -put hadoop-2.6.5.tar.gz 
hdfs dfs -mkdir /user/root
hdfs dfs -ls /user
http://192.168.9.11:50070
for i in `seq 100000`;do  echo "hello sxt $i" >> test.txt;done


**************************************************
hdfs-site.xml

<property>
  <name>dfs.nameservices</name>
  <value>mycluster</value>
</property>
<property>
  <name>dfs.ha.namenodes.mycluster</name>
  <value>nn1,nn2</value>
</property>
<property>
  <name>dfs.namenode.rpc-address.mycluster.nn1</name>
  <value>node01:8020</value>
</property>
<property>
  <name>dfs.namenode.rpc-address.mycluster.nn2</name>
  <value>node02:8020</value>
</property>
<property>
  <name>dfs.namenode.http-address.mycluster.nn1</name>
  <value>node01:50070</value>
</property>
<property>
  <name>dfs.namenode.http-address.mycluster.nn2</name>
  <value>node02:50070</value>
</property>
<property>
  <name>dfs.namenode.shared.edits.dir</name>
  <value>qjournal://node01:8485;node02:8485;node03:8485/mycluster</value>
</property>
<property>
  <name>dfs.journalnode.edits.dir</name>
  <value>/var/sxt/hadoop/ha/jn</value>
</property>
<property>
  <name>dfs.client.failover.proxy.provider.mycluster</name>
  <value>org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider</value>
</property>
<property>
  <name>dfs.ha.fencing.methods</name>
  <value>sshfence</value>
</property>
<property>
  <name>dfs.ha.fencing.ssh.private-key-files</name>
  <value>/root/.ssh/id_dsa</value>
</property>
<property>
   <name>dfs.ha.automatic-failover.enabled</name>
   <value>true</value>
</property>



core-site.xml
<property>
  <name>fs.defaultFS</name>
  <value>hdfs://mycluster</value>
</property>
<property>
   <name>ha.zookeeper.quorum</name>
   <value>node02:2181,node03:2181,node04:2181</value>
 </property>
<property>
    <name>hadoop.tmp.dir</name>
    <value>/var/sxt/hadoop-2.6.5</value>
</property>

配置文件:集群中要同步！！！
zookeepr配置
启动zookeeper集群
zkServer.sh start   ||   zkServer.sh status
hadoop-daemon.sh start journalnode
第一台NN：
hdfs namenode –format
hadoop-deamon.sh start namenode
另一台NN：
hdfs namenode  -bootstrapStandby
start-dfs.sh
$ZOOKEEPER/bin/zkCli.sh 
ls /
hdfs zkfc -formatZK
stop-dfs.sh && start-dfs.sh  ||  hadoop-daemon.sh start zkfc


mapred-site.xml
 <property>
    <name>mapreduce.framework.name</name>
    <value>yarn</value>
 </property>


yarn-site.xml
 <property>
   <name>yarn.nodemanager.aux-services</name>
   <value>mapreduce_shuffle</value>
 </property>
 <property>
   <name>yarn.resourcemanager.ha.enabled</name>
   <value>true</value>
 </property>
 <property>
   <name>yarn.resourcemanager.cluster-id</name>
   <value>cluster1</value>
 </property>
 <property>
   <name>yarn.resourcemanager.ha.rm-ids</name>
   <value>rm1,rm2</value>
 </property>
 <property>
   <name>yarn.resourcemanager.hostname.rm1</name>
   <value>node03</value>
 </property>
 <property>
   <name>yarn.resourcemanager.hostname.rm2</name>
   <value>node04</value>
 </property>
 <property>
   <name>yarn.resourcemanager.zk-address</name>
   <value>node02:2181,node03:2181,node04:2181</value>
 </property>
