module_install(){
    /usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config  --with-mysql=/usr/local/mysql/mysql-5.6.26/
extension=mysql.so
}
