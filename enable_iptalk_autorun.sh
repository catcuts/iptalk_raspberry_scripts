#!/usr/bin/bash

CONF=/etc/rc.local
BKUP=/etc/rc.local.bkup

if [ -f "$BKUP" ]; then
    sudo cp -p $BKUP $CONF  # exists bkup -> recover
else
    sudo cp -p $CONF $BKUP  # not exists bkup -> bkup
fi && \

# sudo sed -in 's/^exit 0/isudo /etc/init.d/mysql restart && sudo bash /home/pi/start.sh && \' $CONF
# sudo sed -in 's/^exit 0/isudo /etc/init.d/mysql restart && sudo python /home/pi/src/iptalk.py && \' $CONF

sudo cp -p ./rc.local $CONF && \
sudo chmod +x $CONF