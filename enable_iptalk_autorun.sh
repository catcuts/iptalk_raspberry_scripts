#!/usr/bin/bash

CONF=/etc/rc.local
BKUP=/etc/rc.local.bkup

if [ -f "$BKUP" ]; then
    sudo cp $BKUP $CONF  # exists bkup -> recover
else
    sudo cp $CONF $BKUP  # not exists bkup -> bkup
fi && \

#sudo sed -in 's/^exit 0/isudo /etc/init.d/mysql restart && sudo python /home/pi/src/iptalk.py' $CONF

sudo cp -p ./rc.local $CONF