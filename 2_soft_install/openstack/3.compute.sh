#!/bin/sh


install_mariadb(){

         yum -y install mariadb mariadb-server python2-PyMySQL

cat > /etc/my.cnf.d/openstack.cnf<<'eof'
[mysqld]
bind-address = 10.20.0.10

default-storage-engine = innodb
innodb_file_per_table = on
max_connections = 4096
collation-server = utf8_general_ci
character-set-server = utf8
eof
systemctl enable mariadb.service
systemctl start  mariadb.service
mysql_secure_installation

}

init_hosts(){

	echo 'HOSTNAME=compute0' > /etc/sysconfig/network

}
