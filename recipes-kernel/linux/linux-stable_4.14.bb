require recipes-kernel/linux/linux-yocto.inc

COMPATIBLE_MACHINE = "wandboard|edm1-cf-imx6"

RDEPENDS_kernel-base += "kernel-devicetree"

KERNEL_DEVICETREE ?= " \
    imx6dl-edm1-cf_fairy.dtb \
    imx6q-edm1-cf_fairy.dtb \
    imx6q-wandboard.dtb \
    imx6q-wandboard-revb1.dtb \
    imx6dl-wandboard.dtb \
    imx6dl-wandboard-revb1.dtb \
"

LINUX_VERSION = "4.14"
LINUX_VERSION_EXTENSION = "-jumpnow"

FILESEXTRAPATHS_prepend := "${THISDIR}/linux-stable-${LINUX_VERSION}:"

S = "${WORKDIR}/git"

PV = "4.14.15"
SRCREV = "a16134b082346b7e7c34f594a0763eafacdcea92"
SRC_URI = " \
    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git;branch=linux-${LINUX_VERSION}.y \
    file://defconfig \
    file://0001-Initial-import-of-technexion-4.1-dts-files.patch \
    file://0002-Search-for-tnmacro.h-in-local-dir.patch \
    file://0003-edm1-cf-Remove-references-to-hdmi-and-other-unused-d.patch \
    file://0004-edm1-cf_fairy-Convert-dts-to-work-with-older-radios.patch \
"
