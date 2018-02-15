require recipes-kernel/linux/linux-yocto.inc

COMPATIBLE_MACHINE = "edm1-cf-imx6"

DEPENDS += "lzop-native bc-native"

RDEPENDS_kernel-base += "kernel-devicetree"

KERNEL_DEVICETREE ?= " \
    imx6dl-edm1-cf_fairy.dtb \
    imx6q-edm1-cf_fairy.dtb \
    imx6dl-edm1-cf-pmic_fairy.dtb \
    imx6q-edm1-cf-pmic_fairy.dtb \
    imx6qp-edm1-cf-pmic_fairy.dtb \
"

LINUX_VERSION = "4.1"
LINUX_VERSION_EXTENSION = "-2.0.0-technexion"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-${LINUX_VERSION}:"

S = "${WORKDIR}/git"

PV = "4.1.15"
SRCREV = "cee96b426d432c9d40a832e8bd1ad2440893f84d"
SRC_URI = " \
    git://github.com/technexion/linux.git;branch=tn-imx_4.1.15_2.0.0_ga \
    file://defconfig \
"
