#!/bin/sh


VER="9.4.1"
PKGNAME="postgresql-9.4.1.tar.gz"
PKGDIR=${PKGNAME%.tar.gz}
PREFIX="/opt/postgresql/$PKGDIR"
SRCDIR=~/sys_scripts/1_server_install
PKGHOME=~/pkg/tmp/$PKGDIR

check_unpack(){
	mkdir  -p   ~/pkg/tmp 
	cp ~/pkg/$PKGNAME  ~/pkg/tmp/
	cd ~/pkg/tmp/
	tar  -zxvf $PKGNAME 
}

check_yum(){
	
	yum  -y install  readline*
}

install_db(){
	 cd $PKGHOME
	./configure --prefix=$PREFIX
	make
	make install

}

check_conf(){
	[ -L /usr/local/pgsql ] && rm  -rf  /usr/local/pgsql
	ln  -s  $PREFIX  /usr/local/pgsql
	\cp $PKGHOME/contrib/start-scripts/linux /etc/init.d/pgsql
	useradd   postgres
	chown postgres:postgres /usr/local/pgsql -R	
	 chown postgres:postgres  $PREFIX   -R
	su -  postgres -c '/usr/local/pgsql/bin/initdb  --pgdata=/usr/local/pgsql/data'
	sed -i '$a host    all             all             192.168.0.1/16            trust' /usr/local/pgsql/data/pg_hba.conf 
	 sed -i 's/.*listen_addresses.*/listen_addresses='"' *'"'/'  /usr/local/pgsql/data/postgresql.conf
	service pgsql restart	
}

	check_yum
#	check_unpack
#	install_db
	check_conf
	
