#!/usr/bin/bash

DEST=/usbmount/raspberrypi.img

sudo dd if=/dev/zero of=$DEST bs=1MB count=2500
sudo parted $DEST --script -- mklabel msdos
sudo parted $DEST --script -- mkpart primary fat32 8192s 122879s
sudo parted $DEST --script -- mkpart primary ext4 122880s -1

loopdevice=`sudo losetup -f --show $DEST`
device=`sudo kpartx -va $loopdevice | sed -E 's/.*(loop[0-9])p.*/\1/g' | head -1`
device="/dev/mapper/${device}"

partBoot="${device}p1"
partRoot="${device}p2"

sudo mkfs.vfat $partBoot
sudo mkfs.ext4 $partRoot

sudo mount -t vfat $partBoot /media
sudo cp -rfp /boot/* /media/
sudo umount /media
sudo mount -t ext4 $partRoot /media/
cd /media
sudo dump -0uaf - / | sudo restore -rf -
cd
sudo umount /media
sudo kpartx -d $loopdevice
sudo losetup -d $loopdevice