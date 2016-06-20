#!/bin/sh

PKGNAME=$1

install_jdk(){
	echo $PKGNAME
	mkdir -p  tmp
	cp  $PKGNAME.tar.gz ./tmp
	cd tmp
	tar  -zxvf  $PKGNAME.tar.gz

	mkdir  -p /opt/jdk/$PKGNAME	
	cp  -r  jdk1.8.0_91  /opt/jdk/$PKGNAME

	#envoriment 
	grep  -q  "java ini"   /etc/profile  || {
	sed  -i  '$a #java ini'  /etc/profile 
	sed  -i '$a export PATH=/opt/jdk/jdk1.8.0_91/bin:/opt/jdk/jdk1.8.0_91/jre/bin:$PATH'  /etc/profile 
	sed  -i '$a export JAVA_HOME=/opt/jdk/jdk1.8.0_91' /etc/profile 
	sed  -i '$a export CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar'  /etc/profile 
	}

	ln  -s /opt/jdk/jdk1.8.0_91/bin  /usr/bin/java
}

install_jre(){
	echo

}


	echo 123
	cd  $HOME/pkg

	install_jdk

	install_jre



