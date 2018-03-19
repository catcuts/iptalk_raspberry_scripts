#!/usr/bin/bash

CONF=/etc/fstab
BKUP=/etc/fstab.bakup

sudo umount -l /dev/sda

disk_detected=`sudo fdisk -l | grep '^Disk /dev/sda'`

if [ -n "$disk_detected" ]; then
    echo -e "Detected: $disk_detected\n\tFormating ..."
    sudo mkfs.ext4 -F /dev/sda
    echo -e "\tFormated."
else
    echo -e "Disk not detected !"
    exit 0
fi

sudo mount -t ext4 /dev/sda /home/pi/src/data

sudo bash mkdir_data.sh

if [ -f "$BKUP" ]; then
    sudo cp -p $BKUP $CONF  # exists bkup -> recover
else
    sudo cp -p $CONF $BKUP  # not exists bkup -> bkup
fi

dev_sda_uuid=0
regex='/dev/sda:\sUUID="([^\s]*)"\s+'
while read line
do
  if [[ $line =~ $regex ]]; then
      dev_sda_uuid="${BASH_REMATCH[1]}"
      echo "UUID: ${uuid}"    # concatenate strings
  fi
done << EOT
`sudo blkid`
EOT

if [ -n dev_sda_uuid ]; then
    sudo echo "UUID=$dev_sda_uuid /home/pi/src/data ext4 defaults 0 0" >> $CONF
else
    echo "Not Found UUID of dev/sda"
    exit 0
fi

cat $CONF

bash mkdir_data.sh