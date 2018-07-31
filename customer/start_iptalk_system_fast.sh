#!/usr/bin/bash
# bash start_iptalk_mysql.sh -c <自定义 mysql 容器名> -d <自定义 mysql 数据存储文件夹> && \
# bash start_iptalk.sh \
# -c <上述 mysql 容器名> \
# -d <自定义 iptalk src 存储文件夹> \
# -n <自定义 iptalk 容器名> \
# -i <iptalk 镜像名> \
# -x <21端口映射> \
# -y <22端口映射>

bash /home/pi/src/run_mysql_container.sh -c iptalk_mysql -i catcuts/mysql:5.7-arm32v6-alpine3.6 -d /home/mysql/data && python /home/pi/src/iptalk.py

#seconds_left=1
#while [ $seconds_left -gt 0 ];do
#    echo -n "请等待 mysql 配置，还有 ${seconds_left} 秒……"
#    # echo -n $seconds_left
#    sleep 1
#    seconds_left=$(($seconds_left - 1))
#    echo -ne "\r                                        \r" #清除本行文字
#done && \

#python /home/pi/src/iptalk.py
