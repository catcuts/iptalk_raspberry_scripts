#!/usr/bin/bash

echo -e "\n\t\t\t-------- install_mysql.sh started --------\n\t\t\t" && \
    MYSQL_EXISTED=`which mysql`
    if [ -z $MYSQL_EXISTED ]; then
        echo "mysql-server mysql-server/root_password password root" | debconf-set-selections && \
        echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections && \
        sudo aptitude install -y mysql-server  # without asking for inputing passwd for root
    fi
    mysql > /dev/null
    if [ $? -eq 0 ]; then
        echo -e "\tERROR: mysql not install, caused by an unexpected error."
    fi
echo -e "\n\t\t\t-------- install_mysql.sh finished --------\n\t\t\t"
