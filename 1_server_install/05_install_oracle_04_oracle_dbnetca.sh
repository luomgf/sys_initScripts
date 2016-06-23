#!/bin/sh

	 . ./05_install_oracle_00_profile.sh 

check_netca(){
	$ORACLE_HOME/bin/netca /silent /responsefile  $PKGHOME/response/netca.rsp	
	$ORACLE_HOME/bin/lsnrctl  status LISTENER
}

check_db(){

	cp $PKGHOME/response/dbca.rsp  $PKGHOME/response/3maodb.rsp

	#sed -i 	-e 's!GDBNAME = .*!GDBNAME = '$ORACLE_SID'!'  \
	#	-e 's!SID = .*!SID = '$ORACLE_SID'!'    $PKGHOME/response/3maodb.rsp 
	$ORACLE_HOME/bin/dbca  -silent  -responseFile $PKGHOME/response/3maodb.rsp 
}

del_db(){
	 $ORACLE_HOME/bin/dbca  -silent   -deleteDatabase   -sourceDB orcl
}
	 check_db
