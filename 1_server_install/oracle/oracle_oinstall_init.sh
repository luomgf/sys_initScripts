#!/bin/sh
        

	pr_log()
	{
		echo -e  "$(date "+[%Y-%m-%d %H:%M:%OS]")\t\t$*\n"
	}


	get_home()
	{

		grep   $1 /etc/passwd|perl -pe  's/(?:[a-zA-Z-0-9:]+)(.*)(?::.*$)/$1/'
	}


	
	pr_log "start run scripts $0 ......."

	#rpm -q ${rpmall}| grep "not installed" &&  {
		
	#	pr_log "[ERROR] install package not all,peleas install"
	#	exit 1
	#}

	 #pr_log "check packege  sucess"

	id | grep -q oracle ||
	{
		pr_log "please oracle run this scripts"
		exit 1
	}

	export	ORACLE_BASE=/u01/app/oracle
	export  ORACLE_SID=luomgdb
	#export  TNS_ADMIN=/u01/app/oracle/
	#export 	NLS_LANG=american_america.zhs16gbk		

	DATA_BASE=/home/oracle/
      RUNINSTALLER_NAME=${DATA_BASE}/database/runInstaller
       RESPONSEFILE_NAME=${DATA_BASE}/database/response/db_install_luomgdb1.rsp
      RESPONSEFILE_NETCA=${DATA_BASE}/database/response/netca.rsp


	${RUNINSTALLER_NAME}  -silent -responseFile  ${RESPONSEFILE_NAME}

	cd /u01/app/oraInventory/logs
	
	echo  ${ORACLE_HOME}	
	 ${ORACLE_HOME}/bin/netca /silent /responsefile  ${RESPONSEFILE_NETCA}

	${ORACLE_HOME}/bin/lsnrctl status


	echo "please input root passwd"
	su root <<EOF
	/u01/app/oracle/product/11.2.0/db_1/root.sh
EOF
