#!/bin/bash

VER="1.6.2"
PKGNAME="spark-$VER-bin-hadoop2.6.tgz"
PKGDIR=${PKGNAME%.tar.gz}
PREFIX="/opt/php/$PKGDIR"
SRCDIR=~/sys_scripts/1_server_install
PKGHOME=~/pkg/tmp/$PKGDIR

http://d3kbcqa49mib13.cloudfront.net/spark-2.0.0-bin-hadoop2.7.tgz
