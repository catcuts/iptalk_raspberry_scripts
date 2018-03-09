#!/usr/bin/bash

echo -e "\n\t\t\t-------- install_mysql.sh started --------\n\t\t\t" && \
    sudo aptitude install -y mysql-server && \
    mysql > /dev/null
    if [ $? -eq 0 ]; then
        echo -e "\tERROR: mysql not install, caused by an unexpected error."
    fi && \
echo -e "\n\t\t\t-------- install_mysql.sh finished --------\n\t\t\t"
