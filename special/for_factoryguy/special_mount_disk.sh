#!/usr/bin/bash

echo "开始 ..."

    bash stop.sh
    bash mount_disk.sh
    bash stop.sh -h

echo "结束. 正在关机 ..."