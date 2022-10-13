[ -f openssl-1.1.1q.tar.gz ] || wget --no-check-certificate https://www.openssl.org/source/openssl-1.1.1q.tar.gz
[ -f openssl-1.1.1q.tar.gz ] || exit 

tar -zxf openssl-1.1.1q.tar.gz

 cd openssl-1.1.1q



mkdir -p /usr/local/lmgs/ssl/1.1.1q
./config shared --prefix=/usr/local/lmgs/ssl/1.1.1q --openssldir=/usr/local/lmgs/ssl/1.1.1q \
    '-Wl,-rpath,$(LIBRPATH)'


make
make install

ln  -s /usr/local/lmgs/ssl/1.1.1q /usr/local/ssl

rm  -rf  openssl-1.1.1q.tar.gz
rm  -rf  openssl-1.1.1q
