
################# v1.0 ################################
目录结构:
sys_scripts
├── 0_sys_init
│   ├── basic_soft.sh
│   └── init.sh
├── 1_server_install
│   ├── 01_install-localyum.sh
│   ├── 02_install-java.sh
│   ├── 03_install_nginx.sh
│   ├── 04_install_php.sh
│   ├── 05_install_oracle_00_profile.sh
│   ├── 05_install_oracle_01_root.sh
│   ├── 05_install_oracle_02_oracle.sh
│   ├── 05_install_oracle_03_root.sh
│   ├── 05_install_oracle_04_oracle_dbnetca.sh
│   ├── 05_install_oracle_05_oracle_tools.sh
│   ├── 06_install_postgres.sh
│   ├── 07_install_httpd.sh
│   ├── 08_install_es.sh
│   ├── 09_install_spark.sh
│   ├── 10_install-mysql.sh
│   ├── clean.sh
│   ├── install-python.sh
│   ├── install-samba.sh
│   ├── install-vim.sh
│   ├── mysql
│   │   ├── my.cnf
│   │   ├── mysqld
│   │   └── readme
│   ├── nginx
│   │   ├── conf
│   │   │   ├── conf.d
│   │   │   │   └── yum.repo.conf
│   │   │   ├── fastcgi.conf
│   │   │   ├── fastcgi.conf.default
│   │   │   ├── fastcgi_params
│   │   │   ├── fastcgi_params.default
│   │   │   ├── koi-utf
│   │   │   ├── koi-win
│   │   │   ├── mime.types
│   │   │   ├── mime.types.default
│   │   │   ├── nginx.conf
│   │   │   ├── nginx.conf.default
│   │   │   ├── scgi_params
│   │   │   ├── scgi_params.default
│   │   │   ├── uwsgi_params
│   │   │   ├── uwsgi_params.default
│   │   │   └── win-utf
│   │   └── nginx.init
│   ├── oracle
│   │   ├── oracle_oinstall_init.sh
│   │   └── root_oinstall_init.sh
│   ├── php
│   │   ├── init.d
│   │   │   └── php-fpm
│   │   ├── php-fpm.conf
│   │   ├── php.ini
│   │   ├── php.ini-development
│   │   └── php.ini-production
│   └── samba
│       ├── init.d
│       │   ├── smb.conf
│       │   ├── smbd
│       │   └── winbind
│       ├── smb.conf
│       ├── smbd
│       └── winbind
└── 2_soft_install
    └── 01_install_git.sh


