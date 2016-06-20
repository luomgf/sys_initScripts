#!/bin/sh


ISONAME=CentOS-7-x86_64-DVD-1511.iso
DIRNAME=${ISONAME%.iso}

getpkgs(){
	mkdir  -p  /mnt/iso
	mkdir  -p  /var/ftp/pub/$DIRNAME

	mount ~/$ISONAME   /mnt/iso
	[ -d /var/ftp/pub/$DIRNAME ] ||
	cp  -rv /mnt/iso/*  /var/ftp/pub/$DIRNAME  
	
	umount   /mnt/iso  	

	cd   /var/ftp/pub/$DIRNAME/Packages
	rpm  -ivh vsftpd*  ftp* createre*   deltarpm-*  libxml2-python-*   python-deltarpm-*

	createrepo -g  /var/ftp/pub/$DIRNAME/repodata/*-comps.xml  /var/ftp/pub/$DIRNAME

}

byfile(){
echo

cat >  /etc/yum.repos.d/file-yum.repo <<'EOF'
##########################
[file-yum]
name=file-yum
baseurl=file:///var/ftp/pub/CentOS-7-x86_64-DVD-1511
enabled=1
gpgcheck=1
gpgkey=file:///var/ftp/pub/CentOS-7-x86_64-DVD-1511/RPM-GPG-KEY-CentOS-7
##########################
EOF
}


byftp(){
echo

cat >  /etc/yum.repos.d/ftp-yum.repo <<'EOF'
##########################
[ftp-yum]
name=ftp-yum
baseurl=ftp://ftp:ftp@192.168.0.7/pub/CentOS-7-x86_64-DVD-1511
enabled=1
gpgcheck=1
gpgkey=ftp://ftp:ftp@192.168.0.7/pub/CentOS-7-x86_64-DVD-1511/RPM-GPG-KEY-CentOS-7
##########################
EOF
}

byhttp(){
echo
cat >  /etc/yum.repos.d/http-yum.repo << 'EOF'
[http-yum]
name=http-yum
baseurl=http://192.168.0.7:5555/CentOS-7-x86_64-DVD-1511
enable=1
gpgcheck=1
gpgkey=http://192.168.0.7:5555/CentOS-7-x86_64-DVD-1511/RPM-GPG-KEY-CentOS-7
EOF
#nginx conf

cat > /etc/nginx/conf.d/yum.repo.conf << 'EOF'
server {
        listen  5555;
        server_name localhost;
        root /var/ftp/pub/;
        # 开启Nginx的目录文件列表
        autoindex on;
        autoindex_exact_size off;
        autoindex_localtime on;
}
EOF

}

updateyum(){
echo
	yum clean all
        yum makecache
        yum list
	yum   repolist
}
	getpkgs
	byfile
	byftp
	byhttp
	updateyum
