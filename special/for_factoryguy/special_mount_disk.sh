#!/usr/bin/bash

echo "开始 ..."

bash ./stop.sh
bash ./mount_disk.sh

echo "硬盘已挂载，请检查:"
df -h

echo -n "重启/关机/再来一次？:[r/h/p]"       #-n选项移调末尾换行符，不换行
read cmd
if [ $cmd == "r" ]; then 
    bash ./stop.sh -r
    echo "结束. 正在重启 ..."
fi
if [ $cmd == "h" ]; then 
    bash ./stop.sh -h 
    echo "结束. 正在关机 ..."
fi
if [ $cmd == "p" ]; then 
    bash ./special_mount_disk.sh
    echo "结束. 正在重来 ..."
fi