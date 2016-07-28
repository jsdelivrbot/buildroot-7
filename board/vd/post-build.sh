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
${RM} -r usr/src

${RM} -r tmp/*

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

