#!/usr/bin/bash

DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M:%S)

LOGFILE_CS=./logs_$DATE_$TIME/correct_sources.log
# LOGFILE_UP=./logs_$DATE_$TIME/update_packages.log

LOGFILE_IM=./logs_$DATE_$TIME/install_mysql.log
LOGFILE_CM=./logs_$DATE_$TIME/config_mysql.log

LOGFILE_CT=./logs_$DATE_$TIME/correct_timezone.log
LOGFILE_IF=./logs_$DATE_$TIME/install_ffmpeg.log

LOGFILE_IP=./logs_$DATE_$TIME/install_packages.log
LOGFILE_MD=./logs_$DATE_$TIME/mkdir_data.log

echo -e "\n\t\t\t======== deployments started ========\n\t\t\t" && \
    bash correct_sources.sh |& tee $LOGFILE_CS && \
    # sudo apt-get update -y |& tee $LOGFILE_UP && \

    bash install_mysql.sh |& tee $LOGFILE_IM && \
    bash config_mysql.sh |& tee $LOGFILE_CM && \

    bash correct_timezone.sh |& tee $LOGFILE_CT && \
    bash install_ffmpeg.sh |& tee $LOGFILE_IF && \

    bash install_packages.sh |& tee $LOGFILE_IP && \
    bash mkdir_data.sh |& tee $LOGFILE_MD && \
echo -e "\n\t\t\t======== deployments finished ========\n\t\t\t"
