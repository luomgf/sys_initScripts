#!/bin/sh

	 . ./05_install_oracle_00_profile.sh 

check_netca(){
	$ORACLE_HOME/bin/netca /silent /responsefile  $PKGHOME/response/netca.rsp	
	$ORACLE_HOME/bin/lsnrctl  status LISTENER
}

check_db(){

	cp $PKGHOME/response/dbca.rsp  $PKGHOME/response/3maodb.rsp

	#$ORACLE_HOME/bin/dbca  -silent \
	 #     -cloneTemplate \
         #     -gdbName  3maodb 
         #     -sid 3maodb  \
         #     -datafileDestination /u01/oradata \
         #     -responseFile $PKGHOME/response/3maodb.rsp \
	 #     -characterSet     AL32UTF8
	$ORACLE_HOME/bin/dbca  -silent  -responseFile $PKGHOME/response/3maodb.rsp 
}

	 check_db
