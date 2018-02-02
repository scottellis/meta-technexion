#!/bin/bash
#
# Create 1 partition for a Wandboard O/S
#

function ver() {
    printf "%03d%03d%03d" $(echo "$1" | tr '.' ' ')
}

if [ -n "$1" ]; then
    DEV=/dev/$1
else
    echo "Usage: sudo $0 <device>"
    echo "Example: sudo $0 sdb"
    exit 1
fi

if [ "$DEV" = "/dev/sda" ] ; then
    echo "Sorry, not going to format $DEV"
    exit 1
fi


echo "Working on $DEV"

#make sure that the SD card isn't mounted before we start
if [ -b ${DEV}1 ]; then
    umount ${DEV}1
    umount ${DEV}2
elif [ -b ${DEV}p1 ]; then
    umount ${DEV}p1
    umount ${DEV}p2
else
    umount ${DEV}
fi

# new versions of sfdisk don't use rotating disk params
sfdisk_ver=`sfdisk --version | awk '{ print $4 }'`

if [ $(ver $sfdisk_ver) -lt $(ver 2.26.2) ]; then
    CYLINDERS=`echo $SIZE/255/63/512 | bc`
    echo CYLINDERS – $CYLINDERS
    SFDISK_CMD="sfdisk --force -D -uS -H255 -S63 -C ${CYLINDERS}"
else
    SFDISK_CMD="sfdisk"
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
} | $SFDISK_CMD $DEV


sleep 1

echo "Done"
