#!/usr/bin/bash

echo -e "\n\t\t\t-------- correct_timezone.sh started --------\n\t\t\t" && \
    sudo apt-get install -y ntpdate && \
    echo "TZ='Asia/Shanghai'; export TZ" >> /root/.profile && \
        sudo timedatectl set-timezone Asia/Chongqing && \
    echo -e "\tplease check: " && \
        cat /etc/timezone && \
        date && \
echo -e "\n\t\t\t-------- correct_timezone.sh finished --------\n\t\t\t"
