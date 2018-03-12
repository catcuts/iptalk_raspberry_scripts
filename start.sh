#!/usr/bin/bash

DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M:%S)
LOGDIR="/home/pi/logs"
_DATE="_$DATE"
_TIME="_$TIME"
LOGFILE="/home/pi/logs/log$_DATE$_TIME.log"
# LOGFILE=$LOGDIR/log_$DATE_$TIME.log

{
    bash ./stop.sh
} || {
    echo ''
} && \

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

# {  # your 'try' block
#     wget && \
#     bash supervior.sh
# } || {  # your 'catch' block
#     echo 'supervisor error'
# }

python /home/pi/src/iptalk.py |& tee -a $LOGFILE
