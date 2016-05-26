#!/bin/sh

#install-mysql.sh 

        PROGNAME="mysql-5.6.26"
        PKGNAME="mysql-5.6.26-linux-glibc2.5-x86_64"
        BASEDIR="/opt/mysql"


        yum install libaio* -y

        [ -f ${PKGNAME}".tar.gz" ] ||  wget http://aliyun-dep.oss-cn-beijing.aliyuncs.com/mysql/${PKGNAME}.tar.gz

        mkdir -p  ${BASEDIR}/${PROGNAME}

        [ -d ${PKGNAME} ]  || tar  -zxf  ${PKGNAME}.tar.gz

        mv  ./${PKGNAME}/*  ${BASEDIR}/${PROGNAME}



        groupadd mysql
        useradd -g mysql -s /sbin/nologin mysql

 cp  ${BASEDIR}/${PROGNAME}/support-files/mysql.server  /etc/init.d/mysqld
sed -i 's#^basedir=$#basedir='${BASEDIR}/${PROGNAME}'#'  /etc/init.d/mysqld
sed -i 's#^datadir=$#datadir='${BASEDIR}/${PROGNAME}'/data#'  /etc/init.d/mysqld
cat > /etc/my.cnf <<END
[client]
port            = 3306
socket          = /tmp/mysql.sock
[mysqld]
explicit_defaults_for_timestamp = true
basedir = /usr/local/mysql/mysql-5.6.26
port            = 3306
socket          = /tmp/mysql.sock
skip-external-locking
log-error=/aliyun/log/mysql/error.log
key_buffer_size = 16M
max_allowed_packet = 1M
table_open_cache = 64
sort_buffer_size = 512K
net_buffer_length = 8K
read_buffer_size = 256K
read_rnd_buffer_size = 512K
myisam_sort_buffer_size = 8M

log-bin=mysql-bin
binlog_format=mixed
server-id       = 1

sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES

[mysqldump]
quick
max_allowed_packet = 16M

[mysql]
no-auto-rehash

[myisamchk]
key_buffer_size = 20M
sort_buffer_size = 20M
read_buffer = 2M
write_buffer = 2M

[mysqlhotcopy]
interactive-timeout
expire_logs_days = 5
max_binlog_size = 1000M
END
