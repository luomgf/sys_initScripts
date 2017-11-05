#!/bin/sh

#install-mysql.sh 

        PROGNAME="mysql-5.6.26"
	PKGDIR="$HOME/pkg"
        PKGNAME="mysql-5.6.26-linux-glibc2.5-x86_64"
        BASEDIR="/opt/mysql"

install_mysql(){

        yum install libaio*  perl perl-devel autoconf  -y

        [ -f ${PKGNAME}".tar.gz" ] ||  wget http://aliyun-dep.oss-cn-beijing.aliyuncs.com/mysql/${PKGNAME}.tar.gz

        mkdir -p  ${BASEDIR}/

        [ -d ${BASEDIR}/${PKGNAME} ]  || tar  -zxvf  ${PKGDIR}/${PKGNAME}.tar.gz -C ${BASEDIR}

	rm  -rf  ${BASEDIR}/${PKGNAME}.tar.gz
 

	ln  -s   ${BASEDIR}/${PKGNAME}  /usr/local/mysql


        groupadd mysql
        useradd -g mysql -s /sbin/nologin mysql
	chown mysql:mysql /usr/local/mysql/data  -R	
	 /usr/local/mysql/scripts/mysql_install_db  --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data 
	/usr/local/mysql/bin/mysqladmin -u root password rootroot
	\cp  ~/sys_scripts/1_server_install/mysql/mysqld  /etc/init.d/mysqld
	\cp  ~/sys_scripts/1_server_install/mysql/my.cnf  /etc/my.cnf
}

uinstall_mysql(){
	
	rm  -rf /opt/mysql
	rm  -rf /usr/local/mysql
	rm  -rf  /etc/init.d/mysqld
	rm  -rf  /etc/my.cnf
}

	cd ~/pkg
	uinstall_mysql
	install_mysql

#/usr/local/mysql/bin/mysql  -uroot  -hlocalhost
#use  mysql
#GRANT ALL PRIVILEGES ON *.* to root@'111.85.174.128' IDENTIFIED BY 'rootroot'   ;
# FLUSH PRIVILEGES;;
