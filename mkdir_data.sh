#!/usr/bin/bash

echo -e "\n\t\t\t-------- making directories for data started --------\n\t\t\t" && \
data_dir=/home/pi/data
ftp_dir=${data_dir}"/ftp"
for dir_name in "" devices ftp logs messages record traceCoords upgrade users
do
  dir=${data_dir}"/"${dir_name}
  if [ ! -d $dir ]
    then mkdir $dir
  fi
done && \
for dir_name in "" Advertising Alram Broadcast Record Upgrade VoiceBroadcast
do
  dir=${ftp_dir}"/"${dir_name}
  if [ ! -d $dir ]
    then mkdir $dir
  fi
done && \
echo -e "\n\t\t\t-------- making directories for data finished --------\n\t\t\t"