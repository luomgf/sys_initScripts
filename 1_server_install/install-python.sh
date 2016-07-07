#!/bin/sh

VER="3.5.2"
PKGNAME="Python-$VER.tgz"
PKGDIR=${PKGNAME%.tgz}
PREFIX="/opt/python/$PKGDIR"
SRCDIR=~/sys_scripts/1_server_install
PKGHOME=~/pkg/tmp/$PKGDIR

install_init(){
	mkdir  -p  $PKGHOME
	cd ~/pkg
}
install_yum(){
	yum install -y  openssl*    sqlite* 
}

install_python(){
#detail version: 2.7.9
PYVER=${1-"3.4.4"}

	cd ~/pkg
	[ -f $PKGNAME ]  ||  
	curl  -O  https://www.python.org/ftp/python/${PYVER}/Python-${PYVER}.tgz
	cp $PKGNAME  ~/pkg/tmp/
	cd ~/pkg/tmp/
	[ -d $PKGHOME ] || tar  -zxf  $PKGNAME
 	cd $PKGHOME
	./configure   --prefix=$PREFIX  \
		--enable-shared        \
 		--enable-loadable-sqlite-extensions  \
 		--enable-ipv6
	make  && make install
	rm  -rf /usr/bin/python
	ln  -s $PREFIX/bin/python${PPYVER}   /usr/bin/python 
	sed    -i   's~#!/usr/bin/python~#!/usr/bin/python2.7~'        /usr/bin/yum
	grep -q  "$PREFIX/bin/"  /etc/profile      || 
	sed  -i   '$a PATH='$PREFIX'/bin/:$PATH ; export  PATH ' /etc/profile 
	[ -L /usr/local/python ] && rm  -rf  /usr/local/python
        ln -s  $PREFIX  /usr/local/python
	python  -V
}

install_yum
install_python  3.5.2

