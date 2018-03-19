#!/usr/bin/bash

DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M:%S)
_DATE="_$DATE"
_TIME="_$TIME"
LOGDIR="./logs$_DATE$_TIME"

echo -e \
"\tparameters:\n\
\t\t$DATE\n\
\t\t$TIME\n\
\t\t$_DATE\n\
\t\t$_TIME\n\
\t\t$LOGDIR"

mkdir -p $LOGDIR

LOGFILE_CS="$LOGDIR/correct_sources.log"
# LOGFILE_UP="$LOGDIR/update_packages.log"

LOGFILE_IM="$LOGDIR/install_mysql.log"
LOGFILE_CM="$LOGDIR/config_mysql.log"

LOGFILE_CT="$LOGDIR/correct_timezone.log"
LOGFILE_IF="$LOGDIR/install_ffmpeg.log"

LOGFILE_IP="$LOGDIR/install_packages.log"
LOGFILE_MD="$LOGDIR/mkdir_data.log"

LOGFILE_IP="$LOGDIR/install_packages.log"
LOGFILE_MD="$LOGDIR/mkdir_data.log"

LOGFILE_AU="$LOGDIR/active_ufw.log"
LOGFILE_EIA="$LOGDIR/enable_iptalk_autorun.log"

LOGFILE_MDI="$LOGDIR/mount_disk.log"

echo -e \
"\tlogfiles:\n\
\t\t$LOGFILE_CS\n\
\t\t$LOGFILE_UP\n\
\t\t$LOGFILE_IM\n\
\t\t$LOGFILE_CM\n\
\t\t$LOGFILE_CT\n\
\t\t$LOGFILE_IF\n\
\t\t$LOGFILE_IP\n\
\t\t$LOGFILE_MD\n\
\t\t$LOGFILE_IP\n\
\t\t$LOGFILE_MD\n\
\t\t$LOGFILE_EIA\n\
\t\t$LOGFILE_MDI" && \

touch \
$LOGFILE_CS \
$LOGFILE_UP \
$LOGFILE_IM \
$LOGFILE_CM \
$LOGFILE_CT \
$LOGFILE_IF \
$LOGFILE_IP \
$LOGFILE_MD \
$LOGFILE_IP \
$LOGFILE_MD \
$LOGFILE_EIA \
$LOGFILE_MDI && \

echo -e "\n\t\t\t======== deployments started ========\n\t\t\t" && \
    bash correct_sources.sh |& tee -a $LOGFILE_CS && \
    # sudo apt-get update -y |& tee -a $LOGFILE_UP && \

    bash install_mysql.sh |& tee -a $LOGFILE_IM && \
    bash config_mysql.sh |& tee -a $LOGFILE_CM && \

    bash correct_timezone.sh |& tee -a $LOGFILE_CT && \
    bash install_ffmpeg.sh |& tee -a $LOGFILE_IF && \

    bash install_packages.sh |& tee -a $LOGFILE_IP && \
    bash mkdir_data.sh |& tee -a $LOGFILE_MD && \

    bash active_ufw.sh |& tee -a $LOGFILE_AU && \
    bash enable_iptalk_autorun.sh |& tee -a $LOGFILE_EIA && \

    bash mount_disk.sh |& tee -a $LOGFILE_MDI && \
    # bash mkdir_data.sh |& tee -a $LOGFILE_MD && \
echo -e "\n\t\t\t======== deployments finished ========\n\t\t\t"
