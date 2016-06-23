#!/bin/sh

init_iptables(){
	iptables -L
	iptables -F
	service iptables save
	systemctl disable firewalld
}

init_selinux(){
	sed -i  's/SELINUX=enforcing/SELINUX=disable/' /etc/sysconfig/selinux
	getenforce
	setenforce  0	
	getenforce
}

init_ldconf(){
	grep -q '/usr/local/lib' /etc/ld.so.conf       || sed '$a /usr/local/lib ' /etc/ld.so.conf
	grep -q '/usr/lib64/' /etc/ld.so.conf          || sed '$a /usr/lib64/'  /etc/ld.so.conf
	for app in $(ls /usr/local)
	do	
	[ -d /usr/local/$app/lib ] || continue
	grep  "/usr/local/$app/lib"  /etc/ld.so.conf.d/luomgf.conf  && continue
	echo "/usr/local/$app/lib" >> /etc/ld.so.conf.d/luomgf.conf
	
	done
	ldconfig  -v
}
	init_iptables
	init_selinux
	init_ldconf
