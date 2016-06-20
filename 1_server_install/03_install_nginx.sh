#!/bin/sh

	PKGNAME="nginx-1.8.0.tar.gz"
	PKGDIR=${PKGNAME%.tar.gz}
	PREFIX=/opt/nginx/$PKGDIR

install_yum(){
	yum install pcre pcre-devel  zlib zlib-devel  openssl openssl-devel  -y
}

install_nginx(){
	
	cp $PKGNAME ./tmp
	cd tmp
	tar  -zxvf  $PKGNAME
	cd	$PKGDIR
	./configure      --prefix=$PREFIX
	make 
	make install
	[ -L /usr/local/nginx ] && rm  -rf  /usr/local/nginx
	ln  -s  /opt/nginx/$PKGDIR  /usr/local/nginx
	[ -L /etc/nginx ] && rm  -rf  /etc/nginx 
	ln  -s  /opt/nginx/$PKGDIR/conf   /etc/nginx	
}	
install_module(){
	echo
}

install_server(){
	echo
	cp ~/sys_scripts/1_server_install/nginx/nginx.init   /etc/init.d/nginx
	chmod +x  /etc/init.d/nginx
	mkdir  -p  /etc/nginx/conf.d
	grep  -q  'include.*conf.d/\*.conf' /etc/nginx/nginx.conf || 
	sed -i '$a include conf.d/*.conf;'  /etc/nginx/nginx.conf 
	
	
}
	mkdir  -p ~/pkg/tmp
	cd ~/pkg
	install_yum
	install_nginx
	install_server	
