#!/usr/bin/bash

echo -e "\n\t\t\t======== deployments started ========\n\t\t\t" && \
    bash correct_sources.sh && \
    sudo apt-get update -y && \
    bash correct_timezone.sh && \
    bash install_mysql.sh && \
    bash config_mysql.sh && \
    bash install_packages.sh && \
    bash install_ffmpeg.sh && \
    bash mkdir_data.sh && \
echo -e "\n\t\t\t======== deployments finished ========\n\t\t\t"
