#!/usr/bin/bash

echo -e "\n\t\t\t-------- change_password.sh started --------\n\t\t\t" && \
    TMP=/home/pi/tmp

    touch $TMP && \
    echo -e "root:meeyi" > $TMP && \
    cat $TMP | sudo chpasswd
echo -e "\n\t\t\t-------- change_password.sh finished --------\n\t\t\t" && \
