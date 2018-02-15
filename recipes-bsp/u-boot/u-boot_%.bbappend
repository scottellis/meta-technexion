FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://0001-Integrate-EDM-CF-IMX6-board-files.patch \
            file://0002-Expand-findfdt-to-detect-PMIC-boards.patch \
           "

UBOOT_SUFFIX = "img"
SPL_BINARY = "SPL"
