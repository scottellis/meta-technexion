require recipes-bsp/u-boot/u-boot.inc

DESCRIPTION = "u-boot for TechNexion boards."
LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

PROVIDES += "u-boot"

SRCBRANCH = "tn-imx_v2016.03_4.1.15_2.0.0_ga"
SRCREV = "5170c7494b19083ad858804396f946f4fa040fd2"
SRC_URI = "git://github.com/TechNexion/u-boot-edm.git;branch=${SRCBRANCH} \
           file://0001-Remove-SPL-FAT-and-SATA-support.patch \
          "

S = "${WORKDIR}/git"

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "edm1-cf-imx6"

UBOOT_SUFFIX = "img"
SPL_BINARY = "SPL"
