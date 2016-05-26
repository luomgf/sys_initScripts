#!/bin/sh
        

	pr_log()
	{
		echo -e  "$(date "+[%Y-%m-%d %H:%M:%OS]")\t\t$*\n"
	}


	get_home()
	{

		grep   $1 /etc/passwd|perl -pe  's/(?:[a-zA-Z-0-9:]+)(.*)(?::.*$)/$1/'
	}

	rpmall="binutils-2.17.50.0.6
compat-libstdc++-33-3.2.3
compat-libstdc++-33-3.2.3
elfutils-libelf-0.125
elfutils-libelf-devel-0.125
gcc-4.1.2
gcc-c++-4.1.2
glibc-2.5-24
glibc-2.5-2
glibc-common-2.5
glibc-devel-2.5
glibc-devel-2.5
glibc-headers-2.5
ksh-20060214
libaio-0.3.106
libaio-0.3.106
libaio-devel-0.3.106
libaio-devel-0.3.106
libgcc-4.1.2
libgcc-4.1.2
libstdc++-4.1.2
libstdc++-4.1.2
libstdc++-d
make-3.81
sysstat-7.0.2
"

	
	#pr_log "start check package....."

	#rpm -q ${rpmall}| grep "not installed" &&  {
		
	#	pr_log "[ERROR] install package not all,peleas install"
	#	exit 1
	#}

	 #pr_log "check packege  sucess"

	id | grep -q root ||
	{
		pr_log "please root run this scripts"
		exit 1
	}

	gname="dba oinstall oper"
	uname="oracle nobody"
	syspara='
	sem shmall shmmax   shmmni shm file-max          file-max 
	ip_local_port_range ip_local_port_range     rmem_default   
	rmem_default rmem_max rmem_max wmem_default wmem_default 
	wmem_max  wmem_max  		semmsl semmns semopm semmni
	'
	id|grep oracle && {	
	export	ORACLE_BASE=/u01/app/oracle
	export  ORACLE_SID=luomgdb
	#export  ORACLE_HOME=/u01/app/oracle/
	#export  TNS_ADMIN=/u01/app/oracle/
	#export 	NLS_LANG=american_america.zhs16gbk		
	}

	RUNINSTALLER_NAME= 
	RESPONSEFILE_NAME=


	for name in $gname
	do
		grep  -q $name  /etc/group || {
		/usr/sbin/groupadd $name 
		pr_log "add group ${name} sucess"
		continue
		}
		pr_log "group ${name} exists"
	done

	
	for name in $uname
        do
                id $name 1>/dev/null 2>&1 || {
                /usr/sbin/useradd $name 
		pr_log "add user ${name} sucess"
		}
		pr_log "user ${name} exists"
        done


	/usr/sbin/usermod -g oinstall -G dba oracle  || {
	pr_log '/usr/sbin/usermod -g oinstall -G dba  oracle  commmod failed'
	exit 1
	}

	 mkdir -p /u01/app/
	 chown -R oracle:oinstall /u01/app/
	 chmod -R 775 /u01/app/


	 userpath=$(get_home oracle)
	pr_log "userpath:${userpath}"

	cat <<EOF > /etc/oraInst.loc 
inventory_loc=/u01/app/oraInventory
inst_group=oinstall
EOF

	chown   oracle:oinstall /etc/oraInst.loc 

	chmod 664  /etc/oraInst.loc 
	cat /etc/sysctl.conf > ./temp.conf
	./change_sysctl.pl     ./temp.conf	
	/sbin/sysctl  -p  ./temp.conf  >/dev/null 2>&1 || {
	pr_log  "sysctl change conf failed"
	exit 1
	}
	
	 pr_log  "sysctl change conf sucess"

	id |grep oracle && {

	${RUNINSTALLER_NAME}  -silent -responseFile  ${RESPONSEFILE_NAME}

	cd /u01/app/oraInventory/logs
	}
	





	#/u01/app/oracle/product/11.2.0/db_1/root.sh
