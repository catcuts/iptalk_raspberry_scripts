#!/usr/bin/bash

echo -e "\n>>> Safety tip: assign variables for the destination and source devices.\n" 
echo -e "\n>>> (Also, if you are doing this more than once, variablization allows you to reuse the commands.)\n"
SOURCE=/dev/sdx
DEST=/dev/sdy

echo -e "\n>>> A note on the source drive (the one you are copying from). \n"
echo -e "\n>>> If you are copying the current OS drive, it will (duh) already be mounted. \n"
echo -e "\n>>> If you are copying a different drive, it actually doesn't need to be mounted.\n"

echo -e "\n>>> Copy the partition table of your source drive out to a file: \n"
sfdisk -d $SOURCE > part_table

echo -e "\n>>> Copy the part_table already stored in a file: \n"
sfdisk --force $DEST < part_table

echo -e "\n>>> Zero out the boot sector: \n"
dd if=/dev/zero of=${DEST}1 bs=512 count=1

echo -e "\n>>> Make your filesystem (one partition at a time): \n"
mkfs -t ext4 ${DEST}1 mkswap ${DEST}2

echo -e "\n>>> Take a look: \n"
parted $DEST --script print

echo -e "\n>>> Copy the label of all non-swap partitions. Example: \n"
tune2fs -L "/" /${DEST}1

echo -e "\n>>> Make a directory to mount the destination device of the dump | restore. \n"
echo -e "\n>>> (As mentioned above, source device need not be mounted.) \n"
mkdir -p /mnt/${DEST}1

echo -e "\n>>> Mount the destination device: \n"
mount -t ext4 ${DEST}1 /mnt/${DEST}1

echo -e "\n>>> cd into the mount point: \n"
cd /mnt/${DEST}1

echo -e "\n>>> Dump and restore: \n\
  dump flags: \
    a=autosize; \
    0 (zero)=start at block 0; \
    f = file, - = stdout \
  restore flags: \
    r=rebuild; \
    f=file; - = stdout\
  The dump | restore should take just a few minutes.\n"
dump -a0f - $SOURCE | restore -rf - 