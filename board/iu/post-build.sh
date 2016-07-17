#!/bin/sh

set -e
RM="rm -f"
MV="mv"
RMDIR="rmdir"
MKDIR="mkdir"

cd ${1}

#${RM} -r etc/dbus-1
#${RM} usr/bin/dbus*
#${RM} usr/lib/libdbus*
#${RM} -r usr/share/dbus-*
#touch usr/libexec/dbus-daemon-launch-helper
#${RM} -r usr/libexec

${RM} lib/systemd/systemd-ac-power
${RM} lib/systemd/systemd-bus-proxyd
${RM} lib/systemd/systemd-cgroups-agent
${RM} lib/systemd/systemd-hostnamed
${RM} lib/systemd/systemd-initctl
${RM} lib/systemd/systemd-sleep
${RM} lib/systemd/systemd-socket-proxyd
${RM} lib/systemd/systemd-update-done
#${RM} usr/bin/systemd-analyze
${RM} lib/systemd/system/sysinit.target.wants/dev-hugepages.mount
${RM} lib/systemd/system/sysinit.target.wants/dev-mqueue.mount
chmod -x lib/systemd/system/*.*

#${RM} usr/bin/systemd-cgls
${RM} usr/bin/systemd-cgtop
${RM} usr/bin/systemd-detect-virt
${RM} usr/bin/systemd-nspawn
#${RM} usr/bin/systemd-resolve
#${RM} usr/bin/systemd-run
${RM} usr/bin/systemd-stdio-bridge
${RM} usr/bin/systemd-sysusers
#${RM} usr/bin/systemd-tty-ask-password-agent
${RM} usr/lib/udev/cdrom_id
${RM} usr/lib/udev/v4l_id

${RM} usr/lib/libevent-*
${RM} usr/lib/libevent_extra*
${RM} usr/lib/libevent_openssl*
${RM} usr/lib/libevent.*

#${RM} usr/bin/gapplication
#${RM} usr/bin/gdbus
#${RM} usr/bin/gdbus-codegen
#${RM} usr/bin/gio-*
#${RM} usr/bin/glib-*
#${RM} usr/bin/gresource
#${RM} usr/bin/gsettings
#${RM} -r usr/lib/gio
#${RM} usr/lib/libexpat*
#${RM} usr/lib/libgio*
#${RM} usr/lib/libglib*
#${RM} usr/lib/libgmodule*
#${RM} usr/lib/libgobject*
#${RM} usr/lib/libgthread*
${RM} -r usr/share/glib-*

#${RM} -r etc/bluetooth
#${RM} -r etc/network
${RM} usr/bin/gettext*
${RM} usr/bin/hidd
${RM} usr/bin/iconv
${RM} usr/bin/ir*
${RM} usr/bin/l2ping
${RM} usr/bin/ldd
${RM} usr/bin/ngettext
#${RM} usr/bin/obex_*
#${RM} usr/bin/pand
#${RM} usr/bin/pon
#${RM} usr/bin/poff
#${RM} usr/bin/rfcomm
#${RM} usr/bin/sdptool

#${RM} usr/lib/libffi*
#${RM} usr/lib/libiconv*
#${RM} usr/lib/libintl*
#${RM} usr/lib/libnsl*

#${RM} usr/sbin/bluetoothd
${RM} usr/sbin/chat
#${RM} usr/sbin/hciattach

${RM} -r usr/lib/pppd
${RM} usr/sbin/pppdump
${RM} usr/sbin/pppoe-discovery
#${RM} usr/sbin/pppstats

#${RM} usr/sbin/ubi*

#${RM} -r usr/share/udhcpc

#${RM} usr/lib32

# usr/share/alsa/cards

exit 0
${RM} -r ../opt
${MKDIR} -p ../opt/itn/lib
${MV} usr/lib/liborc* ../opt/itn/lib/
${MV} usr/lib/libgst* ../opt/itn/lib/
${MV} usr/lib/gstreamer* ../opt/itn/lib/

${MKDIR} -p ../opt/cea/usr/share
${MV} usr/share/mobile-broadband-provider-info ../opt/cea/usr/share/

