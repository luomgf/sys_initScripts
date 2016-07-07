#!/bin/bash

install-elastic (){

VER=${1-2.3.1}
URL="http://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/zip/elasticsearch/${VER}/elasticsearch-${VER}.zip"
PKGNAME="elasticsearch-${VER}.zip"
PREFIX="/opt/elasticsearch/elasticsearch-${VER}"

    export  PATH=$PREFIX/bin:$PATH
    [ -f  elasticsearch-${VER}.zip ] ||  curl  -L  -O  $URL 
    [ -f elasticsearch-${VER}.zip ] || exit 127

    [ -d elasticsearch-${VER} ] || unzip   $PKGNAME 

    cd  elasticsearch-${VER} || exit 127
    
    mkdir  -p $PREFIX
    groupadd elasticsearch
    useradd -g elasticsearch elasticsearch
    chown -R elasticsearch:elasticsearch $PREFIX
    cp -a *  $PREFIX

cat  > /etc/rc.d/init.d/es<<'EOF'
#!/bin/sh
#chkconfig: 2345 80 90
#description:auto_run

#注意上面2 3行不能少
        set  -e
        PREFIX="/opt/elasticsearch/elasticsearch-2.3.1"
        DESC="elasticsearch daemon"
        NAME="elasticsearch"
        ESUSER="elasticsearch"
        PATH=${PREFIX}/bin:$PATH

        DAEMON=${PREFIX}/bin/$NAME 
        SCRIPTNAME=/etc/init.d/$NAME
        JAVA_HOME="/opt/java/jre1.8.0_91"

        export JAVA_HOME

        test -x $DAEMON || echo "$DAEMON not exists or not excute" exit 0
        
        d_start() {

                ps  -ef|grep -v grep |grep  $NAME  > /dev/null && d_status 
            
                su - $ESUSER -c " $DAEMON  -d "
                ps  -ef|grep $NAME || echo $DESC start success 
        }

        d_stop() {
                ps  -ef|grep $NAME |awk '{print "kill  -9 ",$2}'|sh

        }

        d_reload() {

                DAEMON -s reload || echo -n " could not reload"
        }

        d_status() {

                ps  -ef|grep $NAME|grep  -v grep ||
                echo "elasticsearch don't running..."
                exit 0
        }
        case "$1" in 
        start)
                echo  -n "starting $DESC :$NAME"
                d_start
                echo  "."
        ;;
        stop)
                echo -n "stopping $DESC :$NAME"
                d_stop
                echo "."
        ;;
        reload)
                echo  -n "reloading $DESC :$NAME configuration...."
                d_reload
                echo "reloaded."
        ;;
        restart)
                echo  -n "restart $DESC :$NAME "
                d_stop
                sleep 2
                d_start
                echo "."
        ;;
        status)
                d_status
        ;;
        *)
                echo "USAGE:"
                echo "$SCRIPTNAME {start|stop|restart|reload}"  >&2
                exit 3
        ;;
        esac
        exit 0
EOF

$PREFIX/bin/plugin install mobz/elasticsearch-head 
$PREFIX/bin/plugin install https://github.com/NLPchina/elasticsearch-sql/releases/download/2.3.1.0/elasticsearch-sql-2.3.1.0.zip 

chkconfig  --add es
}


install-kibana(){
VER=${1-"4.5.0"}
URL="https://download.elastic.co/kibana/kibana/kibana-$VER-linux-x64.tar.gz"

}

install-elastic

