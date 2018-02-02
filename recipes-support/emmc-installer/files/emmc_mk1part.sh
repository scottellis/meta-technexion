#!/bin/sh
#
# Create 1 partition for a Technexion EDM1-CF-IMX6 
#

DEV=/dev/mmcblk2

echo "Working on $DEV"

# make sure the device isn't mounted before we start
if [ -b ${DEV}1 ]; then
    umount ${DEV}1
    umount ${DEV}2
elif [ -b ${DEV}p1 ]; then
    umount ${DEV}p1
    umount ${DEV}p2
else
    umount ${DEV}
fi

echo "Zeroing the first 4MB"
dd if=/dev/zero of=$DEV bs=1024 count=4096

# Create 1 partition
# Sectors are 512 bytes
# 0-8191: 4MB Not formatted, u-boot
# 8192-end: Linux partition, rootfs

echo "Creating 1 partition"
{
echo 8192,,,*
} | sfdisk $DEV

sleep 1

echo "Done"
