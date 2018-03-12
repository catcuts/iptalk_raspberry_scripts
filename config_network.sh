#!/usr/bin/bash

echo -e "\n\t\t\t-------- config_network.sh started --------\n\t\t\t" && \

CONF=/etc/dhcpcd.conf
BKUP=/etc/dhcpcd.conf.bkup

IP="192.168.1.100"
GATEWAY="192.168.1.1"
DOMAINS="223.5.5.5 223.6.6.6"

while getopts "p:g:d:" arg  # 选项后面的冒号表示该选项需要参数
do
    case $arg in
        p)
            IP=$OPTARG  # 参数存在 $OPTARG 中
            ;;
        g)
            GATEWAY=$OPTARG
            ;;
        d)
            DOMAINS=$OPTARG
            ;;
    esac
done

if [ -f "$BKUP" ]; then
    sudo cp -p $BKUP $CONF  # exists bkup -> recover
else
    sudo cp -p $CONF $BKUP  # not exists bkup -> bkup
fi && \

echo -e "\

interface eth0\n\
 static ip_address=$IP/24\n\
 static routers=$GATEWAY\n\
 static domain_name_servers=$DOMAINS" \
>> /etc/dhcpcd.conf && \

sudo /etc/init.d/networking restart && \

cat /etc/dhcpcd.conf && \

echo -e "\n\t\t\t-------- config_network.sh finished --------\n\t\t\t"

echo -e "\n\t\t\t-------- !! RESTART TO APPLY THE SETTINGS !! --------\n\t\t\t"