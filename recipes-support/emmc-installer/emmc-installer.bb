SUMMARY = "Scripts to support an eMMC installation for Technexion EDM1-CF-IMX6 boards"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://init \
           file://default \
           file://emmc_install_wrapper.sh \
           file://emmc_mk1part.sh \
           file://emmc_copy_boot.sh \
           file://emmc_copy_rootfs.sh \
          "

S = "${WORKDIR}"

do_install_append () {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 init ${D}${sysconfdir}/init.d/emmc-installer

    install -d ${D}${sysconfdir}/default
    install -m 0644 default ${D}${sysconfdir}/default/emmc-installer

    install -d ${D}${bindir}
    install -m 0755 emmc_install_wrapper.sh ${D}${bindir}
    install -m 0755 emmc_mk1part.sh ${D}${bindir}
    install -m 0755 emmc_copy_boot.sh ${D}${bindir}
    install -m 0755 emmc_copy_rootfs.sh ${D}${bindir}
}

FILES_${PN} = "${sysconfdir} ${bindir}"

RDEPENDS_${PN} = "coreutils dosfstools e2fsprogs-mke2fs util-linux" 
