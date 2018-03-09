#!/usr/bin/bash

DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M:%S)
LOGFILE=./log/log$DATE_TIME.txt

bash stop.sh && \

if [ -f `$LOGFILE` ]; then
    echo '' > $LOGFILE
fi && \

echo -e "\n\t\t\t ====== IPTALK RUNNING ======\n\
\n\t\t\t ======   $DATE   ====== \n\t\t\t\
\n\t\t\t ======    $TIME    ====== \n\t\t\t" && \

python /home/pi/src/test.py |& tee -a $LOGFILE
