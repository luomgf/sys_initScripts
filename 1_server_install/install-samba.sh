#!/bin/sh

PJPWD=$PWD
PKGVERSION=4.4.3
PKGNAME=samba-4.4.3.tar.gz
cd ~/pkg

local_install(){
[ -f $PKGNAME ] || wget -r -np -nd --accept=gz --no-check-certificate  https://download.samba.org/pub/samba/stable/samba-4.4.3.tar.gz
[ -d  samba-$PKGVERSION ] || tar -zxvf $PKGNAME

cd  samba-$PKGVERSION 

mkdir  -p  /opt/samba/samba-$PKGVERSION
yum install  gnutls*  libacl*  openldap* -y
#./configure  --prefix=/opt/samba/samba-$PKGVERSION
#make && make install

#ln  -s /opt/samba/samba-$PKGVERSION   /usr/local/samba
cp   ./packaging/RHEL/setup/winbind.init /etc/init.d/winbind
cp   ./packaging/RHEL/setup/smb.init   /etc/init.d/smb
cp   ./examples/tridge/smb.conf   /usr/local/samba/etc

ulimit  -n 2048
}
fChangeConf(){
    grep -q 'nofile' ||
     sed  -i  '$a root      -      nofile       16384' /etc/security/limits.conf
    echo "调整hosts文件"
}
fAdduser(){
mkdir  -p /etc/samba
[ -f  /etc/samba/smbpasswd  ] || touch /etc/samba/smbpasswd
/usr/local/samba/bin/smbpasswd  -a code
}
cd $PJPWD

install_byyum(){
	yum install samba* samba-common-* samba-client*  -y
	smbpasswd  -a code
}

	install_byyum
