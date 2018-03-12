#!/usr/bin/bash

echo -e "\n\t\t\t-------- correct_sources.sh started --------\n\t\t\t" && \
    CONF=/etc/apt/sources.list
    BKUP=/etc/apt/sources.list.bkup

    if [ -f "$BKUP" ]; then
        sudo cp -p $BKUP $CONF  # exists bkup -> recover
    else
        sudo cp -p $CONF $BKUP  # not exists bkup -> bkup
    fi && \

    sed -i "s/^deb\s/#deb /" /etc/apt/sources.list && \
    sed -i "s/^deb-src\s/#deb-src /" /etc/apt/sources.list && \

    sed -in "1i\
deb http://mirrors.aliyun.com/raspbian/raspbian/ jessie main non-free contrib rpi\n\
deb-src http://mirrors.aliyun.com/raspbian/raspbian/ jessie main non-free contrib rpi" \
/etc/apt/sources.list && \
    
#     sed -in "1i\
# deb http://mirrors.aliyun.com/raspbian/raspbian/ wheezy main non-free contrib rpi\n\
# deb-src http://mirrors.aliyun.com/raspbian/raspbian/ wheezy main non-free contrib rpi" \
# /etc/apt/sources.list && \
    
    sudo apt-get update -y && \
echo -e "\n\t\t\t-------- correct_source.sh finished --------\n\t\t\t"
