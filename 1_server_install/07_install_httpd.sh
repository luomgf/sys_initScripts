#!/bin/sh

VER=${1-"2.4.23"}
SOFTNAME="httpd"
PKGNAME="httpd-${VER}.tar.gz"
PKGDIR=${PKGNAME%.tar.gz}
PREFIX="/opt/$SOFTNAME/$PKGDIR"
SRCDIR=~/sys_scripts/1_server_install
PKGHOME=~/pkg/tmp/$PKGDIR

check_upack(){

	mkdir  -p ~/pkg/tmp 
	cd  ~/pkg
	cp  $PKGNAME ~/pkg/tmp/
	cd  ~/pkg/tmp/
	tar -zxvf $PKGNAME 

}

check_yum(){
	yum install  -y apr-*  lynx
}
check_build(){
	cd $PKGHOME
	./configure --prefix=$PREFIX 
}

check_install(){
	make 
	make install	
	[ -L /usr/local/httpd ] && rm  -rf  /usr/local/httpd
	
	ln  -s  $PREFIX /usr/local/httpd
	[ -L /usr/sbin/httpd ] && rm -rf  /usr/sbin/httpd
	ln -s /usr/local/httpd/bin/httpd  /usr/sbin/httpd
	\cp ./support/apachectl /etc/init.d/httpd 
	mkdir  -p /etc/httpd
	[ -L /etc/httpd/conf ] && rm  -rf /etc/httpd/conf 
	ln -s /usr/local/httpd/conf /etc/httpd/conf 
}
	check_upack
	check_yum
	check_build
	check_install
