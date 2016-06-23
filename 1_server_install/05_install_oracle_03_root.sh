#!/bin/sh

check_env(){

grep  '#oracle_env' /etc/profile  || 
cat  >>  /etc/profile  <<'EOF'
#oracle_env
	export ORACLE_OWNER=oracle
    	export ORACLE_HOME=/u01/app/oracle/product/11.2.0/db_1
	export  TNS_ADMIN=/u01/app/oracle/
        export  NLS_LANG=american_america.zhs16gbk
		ORACLE_BASE=/u01/app/oracle
		ORACLE_SID=orcl11g
	export ORACLE_BASE ORACLE_SID
	export PATH=$ORACLE_HOME/bin:$PATH
EOF



}

	
	/u01/app/oracle/product/11.2.0/db_1/root.sh
	check_env
