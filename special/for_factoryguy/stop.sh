#!/usr/bin/bash

halt=0
restart=0

while getopts "hr" arg  # 选项后面的冒号表示该选项需要参数
do
    case $arg in
        h)
            halt=1  # 参数存在 $OPTARG 中
            ;;
        r)
            restart=1
            ;;
    esac
done

pid=`pgrep -f iptalk.py`

if [ -n "$pid" ]; then
    echo "iptalk stopping ..." && \
    sudo kill -9 $pid && \
    echo "iptalk stopped."
fi && \

if [[ $halt -eq 1 ]]; then
    echo "system halting ..."
    sudo shutdown -h now
elif [[ $restart -eq 1 ]]; then
    echo "system rebooting ..."
    sudo shutdown -r now
fi