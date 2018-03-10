#!/usr/bin/bash

echo -e "\t-------- active_ufw.sh started --------" && \

ufw status > /dev/null
if [ $? -eq 0 ]; then
    echo -e "\tufw configing ..."
else 
    echo -e "\tinstalling ufw ..." && \
    sudo apt-get update -y && \
    sudo apt-get install -y --force-yes ufw && \
    echo -e "\tufw installed. ufw configing ..."
fi && \

sudo ufw --force enable reset && \
sudo ufw allow from 10.0.0.0/8 to any port 22 && \
sudo ufw allow from 172.16.0.0/12 to any port 22 && \
sudo ufw allow from 192.168.0.0/16 to any port 22 && \
sudo ufw --force enable deny from any to any port 2 && \
sudo ufw allow from any to any && \
sudo ufw --force enable enable && \
sudo ufw status && \

echo -e "\t-------- active_ufw.sh finished --------"