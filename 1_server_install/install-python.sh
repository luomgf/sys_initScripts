#!/bin/sh

VER="3.10.1"
PKGNAME="Python-$VER.tgz"
PKGDIR=${PKGNAME%.tgz}
PREFIX="/opt/python/$PKGDIR"
SRCDIR=~/sys_scripts/1_server_install
PKGHOME="~/pkg/tmp/$PKGDIR"

install_init(){
        mkdir  -p  $PKGHOME
        cd ~/pkg
}
install_yum(){
        yum install -y  openssl*    sqlite*  libffi-devel 
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
        cd  $PKGDIR
        ./configure   --prefix=$PREFIX  \
                --enable-shared        \
                --enable-loadable-sqlite-extensions  \
                --enable-ipv6		\
		--with-openssl=/usr/local/ssl/
        make  && make install
        }


OnlyPython_ini(){
#单独安装python模式，特殊设置
	grep  $PREFIX/bin  /etc/profile  || sed  -i   '$a export PATH='$PREFIX'/bin/:$PATH  '   /etc/profile  
	grep  $PREFIX/lib  /etc/profile  ||  sed  -i   '$a export LD_LIBRARY_PATH='$PREFIX'/lib:$LD_LIBRARY_PATH'    /etc/profile

	python3 -V

}


sys_ini(){
#采用统一范式安装，在/usr/local目录安装或者建立软链接，系统统一加载
rm  -rf /usr/bin/python
        ln  -s $PREFIX/bin/python${PPYVER}   /usr/bin/python 
        sed    -i   's~#!/usr/bin/python$~#!/usr/bin/python2.7~'        /usr/bin/yum
        grep -q  "$PREFIX/bin/"  /etc/profile      || 
        sed  -i   '$a PATH='$PREFIX'/bin/:$PATH ; export  PATH ' /etc/profile 
        [ -L /usr/local/python ] && rm  -rf  /usr/local/python
        ln -s  $PREFIX  /usr/local/python
        python  -V
}

install_yum
install_python  $VER
#sys_ini
OnlyPython_ini 
