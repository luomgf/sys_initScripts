#!/bin/sh


	. ./05_install_oracle_00_profile.sh  


silent_install(){
	echo
	cd $PKGHOME
	$PKGHOME/runInstaller  -silent -responseFile  $PKGHOME/response/3mao.rsp 
	
	
}

	silent_install
