#!/usr/bin/bash

echo -e "\n\t\t\t-------- enable_ssh_root.sh started --------\n\t\t\t" && \

    CONF=/etc/ssh/sshd_config
    BKUP=/etc/ssh/sshd_config.bkup

    if [ -f "$BKUP" ]; then
        sudo cp -p $BKUP $CONF  # exists bkup -> recover
    else
        sudo cp -p $CONF $BKUP  # not exists bkup -> bkup
    fi && \

    sed -in "s/^PermitRootLogin without-password/PermitRootLogin yes/" $CONF

echo -e "\n\t\t\t-------- enable_ssh_root.sh finished --------\n\t\t\t"

echo -e "\n\t\t\t-------- !! RESTART TO APPLY THE SETTINGS !! --------\n\t\t\t"