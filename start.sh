#!/usr/bin/bash

DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M:%S)
LOGDIR=/home/pi/logs
LOGFILE=$LOGDIR/log_$DATE_$TIME.log

bash stop.sh && \

if [ ! -d $LOGDIR ]; then
    mkdir -p $LOGDIR
fi && \

if [ -f $LOGFILE ]; then
    echo '' > $LOGFILE
else
    touch $LOGFILE
fi && \

echo -e "\n\t\t\t ====== IPTALK RUNNING ======\n\
\n\t\t\t ======   $DATE   ====== \n\t\t\t\
\n\t\t\t ======    $TIME    ====== \n\t\t\t" && \

python /home/pi/src/iptalk.py |& tee -a $LOGFILE
