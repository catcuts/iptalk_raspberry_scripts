#!/usr/bin/bash

halt=0
restart=0

while getopts "-hr" arg  # 选项后面的冒号表示该选项需要参数
do
    case $arg in
        h)
            halt=$OPTARG  # 参数存在 $OPTARG 中
            ;;
        r)
            restart=$OPTARG
            ;;
    esac
done

pid=`pgrep -f test.py` && \

if [ $[`$pid >= 0`] ]; then
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
