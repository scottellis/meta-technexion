#!/bin/sh
#
# Script to install a system onto the Technexion EDM1-CF-IMX6 eMMC.
# This script handles the root file system partition.
#
# Run it like this:
#
#  ./emmc_copy_rootfs.sh <image-file> [ <hostname> ]
#

MACHINE=edm1-cf-imx6
DEV=/dev/mmcblk2p1

if [ -z "${SRC}" ]; then
    SRC=.
else
    if [ ! -d "${SRC}" ]; then
        echo "Source directory not found: ${SRC}"
        exit 1
    fi
fi

if [ "x${1}" = "x" ]; then
    echo -e "\nUsage: ${0} <image-name> [<hostname>]\n"
    exit 0
fi

if [ ! -d /media ]; then
    echo "Mount point /media does not exist"
    exit 1
fi

if [ ! -b $DEV ]; then
    echo "Block device not found: $DEV"
    exit 1
fi

if [ -f "${1}" ]; then
    FULLPATH="${1}"
elif [ -f "${SRC}/${1}" ]; then
    FULLPATH="${SRC}/${1}"
elif [ -f "${SRC}/${1}-${MACHINE}.tar.xz" ]; then
    FULLPATH="${SRC}/${1}-${MACHINE}.tar.xz"
elif [ -f "${SRC}/${1}-image-${MACHINE}.tar.xz" ]; then
    FULLPATH="${SRC}/${1}-image-${MACHINE}.tar.xz"
else
    echo "Rootfs image file not found."
    echo "Tried the following:"
    echo "${1}"
    echo "${SRC}/${1}"
    echo "${SRC}/${1}-${MACHINE}.tar.xz"
    echo "${SRC}/${1}-image-${MACHINE}.tar.xz"
    exit 1
fi
 
if [ "x${2}" = "x" ]; then
        TARGET_HOSTNAME=$MACHINE
else
        TARGET_HOSTNAME=${2}
fi

echo -e "HOSTNAME: $TARGET_HOSTNAME\n"

echo "Formatting $DEV as ext4"
mkfs.ext4 -q -F $DEV

echo "Mounting $DEV as /media"
mount $DEV /media

echo "Extracting ${FULLPATH} to  /media"
tar -C /media -xJf ${FULLPATH}

echo "Writing hostname to /etc/hostname"
export TARGET_HOSTNAME
echo ${TARGET_HOSTNAME} > /media/etc/hostname        

if [ -f ${SRC}/interfaces ]; then
    echo "Writing interfaces to /media/etc/network/"
    cp ${SRC}/interfaces /media/etc/network/interfaces
fi

if [ -f ${SRC}/wpa_supplicant.conf ]; then
    echo "Writing wpa_supplicant.conf to /media/etc/"
    cp ${SRC}/wpa_supplicant.conf /media/etc/wpa_supplicant.conf
fi

echo "Renaming boot.scr"
if [ -f /media/boot/boot.scr ]; then
    mv /media/boot/boot.scr /media/boot/sdcard-boot.scr
fi

if [ ! -f /media/boot/emmc-boot.scr ]; then
    echo "Failed to find emmc-boot.scr in /boot of new rootfs"
    umount $DEV
    exit 1
else
    cp /media/boot/emmc-boot.scr /media/boot/boot.scr
fi
 
echo "Unmounting $DEV"
umount $DEV

echo "Done"
