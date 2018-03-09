#!/usr/bin/bash

echo -e "\n\t\t\t-------- config_mysql.sh started --------\n\t\t\t" && \
    # do some historically left operations
    mysql -uroot -proot <<EOF
	   use mysql;
	   update user set host='%' where user='root' and host='localhost';
EOF

    # stop mysql service
    echo -e "\tMysql stopping ..." && \
        sudo /etc/init.d/mysql stop && \
    echo -e "\tMysql stopped. Mysql configing ..." && \

        # use our config (character utf8) for mysql
        sudo mv /etc/mysql/my.cnf /etc/mysql/my.cnf.bkup && \
        sudo cp -p ./my.cnf /etc/mysql/my.cnf && \

    # start mysql service
    echo -e "\tMysql configed. Mysql restarting ..." && \
        sudo /etc/init.d/mysql start && \
    echo -e "\tMysql restarted." && \
echo -e "\n\t\t\t-------- config_mysql.sh finished --------\n\t\t\t"