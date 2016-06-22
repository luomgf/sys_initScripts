#!/bin/sh

	. ./05_install_oracle_00_profile.sh  
#http://docs.oracle.com/cd/E11882_01/install.112/e24326/toc.htm#CEGIHDBF
check_env(){
echo
SWAPSIZE=$(free swap|awk  'NR==3{print $2}' )

if [ $SWAPSIZE -lt 4000000 ] ; then 
	 dd if=/dev/zero of=/swap bs=1024 count=2048000
	mkswap  /swap
	swapon  /swap
	#/swap swap swap defaults 0 0 #add /etc/fstab
	echo "swap add swapfile success"
else
	echo "swap already success"
fi
}

check_yum(){
yum -y  install  binutils-* \
compat-libcap1-*  \
gcc-*  \
gcc-c++-*  \
glibc-*  \
glibc-*  \
glibc-devel-*  \
glibc-devel-*  \
ksh \
libaio-*  \
libaio-*  \
libaio-devel-*  \
libgcc-* \
libstdc++* \
libXi-* \
libXtst*  \
libXtst-* \
make-* \
unixODBC* \
sysstat-* \
pdksh*    \
elfutils-libelf* \
compat-libstdc++*  

yum install http://mirror.centos.org/centos/5/os/x86_64/CentOS/pdksh-5.2.14-37.el5_8.1.x86_64.rpm -y

}

check_conf(){

cat > /etc/oraInst.loc <<'EOF'
inventory_loc=/u01/app/oraInventory
inst_group=oinstall
EOF
/usr/sbin/groupadd oinstall
/usr/sbin/groupadd dba
 /usr/sbin/usermod -g oinstall -G dba oracle
/usr/sbin/useradd -g oinstall -G dba oracle
echo oracleoracle| passwd --stdin oracle



}
check_limit(){
grep  	'#oracle_conf'  /etc/sysctl.conf  ||
cat >>/etc/sysctl.conf <<'EOF'
#oracle_conf
fs.aio-max-nr = 1048576
fs.file-max = 6815744
kernel.shmall = 2097152
kernel.shmmax = 536870912
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
EOF


	/sbin/chkconfig boot.sysctl on
	/sbin/sysctl -p
	/sbin/sysctl -a

	echo 501 > /proc/sys/vm/hugetlb_shm_group
	
	#/etc/security/limits.conf
	grep '#oracle_limit' /etc/security/limits.conf || {
cat >> /etc/security/limits.conf<<'EOF'
#oracle_limit
oracle              soft    nproc   2047
oracle              hard    nproc   16384
oracle              soft    nofile  1024
oracle              hard    nofile  65536
oracle              soft    stack   10240
EOF
}

}

check_dirs(){
 mkdir -p /u01/app/
 chown -R oracle:oinstall /u01/app/
 chmod -R 775 /u01/app/
}

check_uppkg(){
	cd  /home/oracle/pkg/oracle
	[ -d database ]  || {
	unzip  $PKGNAME1
	unzip  $PKGNAME2
	}
	cd  database
}
check_rspfile(){
	echo
	cd $PKGHOME
	
	cp   ./response/db_install.rsp  ./response/3mao.rsp

	sed  -i -e 's/oracle.install.option=$/oracle.install.option=INSTALL_DB_SWONLY/'  \
		-e 's/ORACLE_HOSTNAME=$/ORACLE_HOSTNAME=3mao/' \
		-e 's/UNIX_GROUP_NAME=$/UNIX_GROUP_NAME=oinstall/' \
		-e 's!INVENTORY_LOCATION=$!INVENTORY_LOCATION=/u01/app/oracle/oraInventory!' \
		-e 's!SELECTED_LANGUAGES=$!SELECTED_LANGUAGES=en!' \
		-e 's!ORACLE_HOME=$!ORACLE_HOME=/u01/app/oracle/product/11.2.0/db_1!' \
		-e 's!ORACLE_BASE=!ORACLE_BASE=/u01/app/oracle!'   \
		-e 's!oracle.install.db.InstallEdition=$!oracle.install.db.InstallEdition=EE!'  \
		-e 's!oracle.install.db.isCustomInstall=$!oracle.install.db.isCustomInstall=true!' \
		-e 's!oracle.install.db.DBA_GROUP=$!oracle.install.db.DBA_GROUP=dba!' \
		-e 's!oracle.install.db.OPER_GROUP=$!oracle.install.db.OPER_GROUP=oinstall!' \
		-e 's!oracle.install.db.config.starterdb.SID=$!oracle.install.db.config.starterdb.SID=3mao!'  \
		-e 's!oracle.install.db.config.starterdb.characterSet=$!oracle.install.db.config.starterdb.characterSet=AL32UTF8!' \
		-e 's!oracle.install.db.config.starterdb.password.ALL=$!oracle.install.db.config.starterdb.password.ALL=oracle!'  \
		-e 's!DECLINE_SECURITY_UPDATES=$!DECLINE_SECURITY_UPDATES=true!' \
	./response/3mao.rsp	

}
	check_yum
	check_env
	check_conf
	check_limit
	check_dirs
	check_uppkg
	check_rspfile
