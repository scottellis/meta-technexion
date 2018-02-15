SUMMARY = "Broadcom Wi-fi & bluetooth firmware"
DESCRIPTION = "Broadcom Wi-fi & bluetooth firmware"
SECTION = "base"
LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://README;md5=fbb735cdf686be2681ddc018d40c0478"

SRC_URI += " \
    file://README \
    file://fw_bcm4339a0_ag.bin \
    file://fw_bcm4339a0_ag_apsta.bin \
    file://nvram_ap6335.txt \
    file://bcm4339a0.hcd \
    file://fw_bcm43438a0.bin \
    file://fw_bcm43438a0_apsta.bin \
    file://nvram_ap6212.txt \
    file://bcm43438a0.hcd \
"

S = "${WORKDIR}"

do_install() {
    install -d ${D}/lib/firmware/brcm

    #Install AP6335 wifi and bluetooth firmware
    install -m 0755 fw_bcm4339a0_ag.bin ${D}/lib/firmware/brcm
    install -m 0755 fw_bcm4339a0_ag_apsta.bin ${D}/lib/firmware/brcm
    install -m 0755 nvram_ap6335.txt ${D}/lib/firmware/brcm
    install -m 0755 bcm4339a0.hcd ${D}/lib/firmware/brcm

    #Install AP6212 wifi and bluetooth firmware
    install -m 0755 fw_bcm43438a0.bin ${D}/lib/firmware/brcm
    install -m 0755 fw_bcm43438a0_apsta.bin ${D}/lib/firmware/brcm
    install -m 0755 nvram_ap6212.txt ${D}/lib/firmware/brcm
    install -m 0755 bcm43438a0.hcd ${D}/lib/firmware/brcm
}

FILES_${PN}-dbg += "/lib/firmware/.debug"
FILES_${PN} += "/lib/firmware/"

COMPATIBLE_MACHINE = "edm1-cf-imx6"
