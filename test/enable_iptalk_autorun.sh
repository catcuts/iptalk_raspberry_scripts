#!/usr/bin/bash

CONF=./rc.local
BKUP=./rc.local.bkup

if [ -f "$BKUP" ]; then
    sudo cp -p $BKUP $CONF  # exists bkup -> recover
else
    sudo cp -p $CONF $BKUP  # not exists bkup -> bkup
fi && \

scripts="
{  # your 'try' block
\n\t  if [ ! -d "/run/mysqld" ]; then
\n\t\t  mkdir -p /run/mysqld
\n\t  fi && \\
\n\t  /etc/init.d/mysql restart && sudo bash /home/pi/start.sh
\n} || {  # your 'catch' block
\n\t  echo '[ERROR] Failed to auto running IPTalk'
\n}
\n\nexit 0"

total=`sed -n '$=' $CONF`  # 计算文件的总行数
for i in `seq $total -1 1`;do
    line=$(sed -n "`expr $i`p" $CONF)  # 倒数第 i 行
    if [[ $line =~ "exit 0" ]]; then  # 如果该行包含 exit 0
        sed -i "`expr $i`d" $CONF  # 则删除该行
        break  # 退出循环
    fi
done
echo -e $scripts >> $CONF

# # sudo sed -in 's/^exit 0/isudo /etc/init.d/mysql restart && sudo bash /home/pi/start.sh && \' $CONF
# # sudo sed -in 's/^exit 0/isudo /etc/init.d/mysql restart && sudo python /home/pi/src/iptalk.py && \' $CONF

# sudo cp -p ./rc.local $CONF && \
# sudo chmod +x $CONF