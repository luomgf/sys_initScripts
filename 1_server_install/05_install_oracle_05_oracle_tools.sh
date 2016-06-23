#!/bin/sh

	 . ./05_install_oracle_00_profile.sh 

make_start(){

cat > /home/oracle/ostart.sh <<EOF
$ORACLE_HOME/bin/lsnrctl  start   LISTENER 
sqlplus / as sysdba <<SQL
starup
SQL
EOF

}

make_stop(){
	cat > /home/oracle/ostop.sh <<EOF
$ORACLE_HOME/bin/lsnrctl  stop   LISTENER  
sqlplus / as sysdba <<SQL
shutdown immeidate  ;
SQL
EOF
}

	make_start
	make_stop
