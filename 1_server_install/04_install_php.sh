#!/bin/bash

VER="5.6.20"
PKGNAME="php-$VER.tar.gz"
PKGDIR=${PKGNAME%.tar.gz}
PREFIX="/opt/php/$PKGDIR"
SRCDIR=~/sys_scripts/1_server_install


install-yum(){
	yum install  -y  libxml2  libxml2-devel
}

install-php(){

    export  PATH=$PREFIX/bin:$PATH

    [ -f $PKGNAME ] || { 
    echo "not exists "
    exit 127 
    }
	cp $PKGNAME ./tmp
	cd  tmp

    [ -d "php-$VER" ] || tar -zxvf  $PKGNAME
    mkdir  -p $PREFIX 

    cd  php-$VER  || exit 127
   ./configure  --prefix=$PREFIX \
       --enable-fpm

    make  &&  make install
   [ -L /usr/local/php ] && rm  -rf  /usr/local/php
   [ -L /etc/php ] &&  rm  -rf  /etc/php
   ln  -s  $PREFIX  /usr/local/php
   ln  -s  $PREFIX/etc /etc/php
    cp $SRCDIR/php/init.d/php-fpm   /etc/rc.d/init.d/php-fpm
    chmod 755  /etc/rc.d/init.d/php-fpm
    chkconfig  --add php-fpm
   \cp -r $SRCDIR/php/php.ini       /etc/php/
   \cp -r $SRCDIR/php/php-fpm.conf  /etc/php/ 
    grep $PREFIX /etc/profile >/dev/null ||  sed  -i '$a export  PATH='$PREFIX'/bin:$PATH' /etc/profile

}
module_install(){
    /usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config  --with-mysql=/usr/local/mysql/mysql-5.6.26/
extension=mysql.so
}
install-php-fpm(){
echo ""
}
	mkdir  -p ~/pkg/tmp
	cd ~/pkg
	install-yum	
	install-php

