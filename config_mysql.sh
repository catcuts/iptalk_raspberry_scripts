#!/usr/bin/bash

CONF=/etc/mysql/my.cnf
BKUP=/etc/mysql/my.cnf.bkup

echo -e "\n\t\t\t-------- config_mysql.sh started --------\n\t\t\t" && \
    # set root's passwd
    mysql -u root <<EOF
        SET PASSWORD FOR 'root'@'localhost' = PASSWORD('root');
EOF

    # do some historically left operations (don't know why but better not to remove it)
    mysql -uroot -proot <<EOF
	   use mysql;
	   update user set host='%' where user='root' and host='localhost';
EOF

    # stop mysql service
    echo -e "\tMysql stopping ..." && \
        sudo /etc/init.d/mysql stop && \
    echo -e "\tMysql stopped. Mysql configing ..." && \

        # use prefabricated config (character utf8) for mysql
        if [ -f "$BKUP" ]; then
            sudo cp -p $BKUP $CONF  # exists bkup -> recover
        else
            sudo cp -p $CONF $BKUP  # not exists bkup -> bkup
        fi && \

        sudo cp -p ./my.cnf $CONF && \

    # start mysql service
    echo -e "\tMysql configed. Mysql restarting ..." && \
        sudo /etc/init.d/mysql start && \
    echo -e "\tMysql restarted." && \
echo -e "\n\t\t\t-------- config_mysql.sh finished --------\n\t\t\t"