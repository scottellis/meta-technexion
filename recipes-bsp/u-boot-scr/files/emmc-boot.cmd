setenv bootpart 0:1
setenv bootdir /boot
setenv mmcroot /dev/mmcblk2p1 ro
setenv mmcrootfstype ext4 rootwait
setenv display video=mxcfb0:dev=hdmi,1920x1080M@60,if=RGB24 fbmem=28M
setenv bootargs console=${console} root=${mmcroot} rootfstype=${mmcrootfstype} ${display}
run findfdt
load mmc ${bootpart} ${fdt_addr} ${bootdir}/${fdtfile}
load mmc ${bootpart} ${loadaddr} ${bootdir}/zImage
bootz ${loadaddr} - ${fdt_addr}
