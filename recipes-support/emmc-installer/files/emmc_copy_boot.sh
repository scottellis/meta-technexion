#!/bin/sh
#
# Script to install a system onto the Technexion EDM1-CF-IMX6 eMMC
# This script handles the bootloader on unpartitioned space.
#
# This script should normally be run as
#
#  ./emmc_copy_boot.sh
#
# Assumes the following files are available in the local directory:
#
#   1) SPL-${MACHINE}
#   2) u-boot-${MACHINE}.img
#

MACHINE=edm1-cf-imx6
DEV=/dev/mmcblk2

if [ -z "${SRC}" ]; then
    SRC=.
else
    if [ ! -d "${SRC}" ]; then
        echo "Source directory not found: ${SRC}"
        exit 1
    fi
fi

if [ ! -b ${DEV} ]; then
    echo "Block device not found: ${DEV}"
    exit 1
fi

if [ ! -f ${SRC}/SPL-${MACHINE} ]; then
    echo -e "File not found: ${SRC}/SPL-${MACHINE}\n"
    exit 1
fi

if [ ! -f ${SRC}/u-boot-${MACHINE}.img ]; then
    echo -e "File not found: ${SRC}/u-boot-${MACHINE}.img\n"
    exit 1
fi

echo "Using dd to copy SPL to unpartitioned space"
dd if=${SRC}/SPL-${MACHINE} of=${DEV} conv=notrunc seek=2 skip=0 bs=512

echo "Using dd to copy u-boot to unpartitioned space"
dd if=${SRC}/u-boot-${MACHINE}.img of=${DEV} conv=notrunc seek=69 skip=0 bs=1K

echo "Done"
