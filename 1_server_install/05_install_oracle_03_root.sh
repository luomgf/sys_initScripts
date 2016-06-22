#!/bin/sh

check_env(){

grep  '#oracle_home' /etc/profile  || 
cat  >>  /etc/profile  <<'EOF'
	export  TNS_ADMIN=/u01/app/oracle/
        export  NLS_LANG=american_america.zhs16gbk
	export  ORACLE_HOME=/u01/app/oracle/
EOF


grep "#oracle_env"  /etc/profile ||
cat >>  /etc/profile  <<'EOF'
ORACLE_BASE=/u01/app/oracle
ORACLE_SID=3mao
export ORACLE_BASE ORACLE_SID
EOF

}
