#!/bin/sh

#set -e
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

echo "599ae83dc44544f29b4e4a4a344fdfc5" > etc/machine-id
${RM} lib/systemd/systemd-ac-power
${RM} lib/systemd/systemd-bus-proxyd
${RM} lib/systemd/systemd-cgroups-agent
${RM} lib/systemd/systemd-hostnamed
${RM} lib/systemd/systemd-initctl
${RM} lib/systemd/systemd-sleep
${RM} lib/systemd/systemd-socket-proxyd
${RM} lib/systemd/systemd-update-done
${RM} lib/systemd/system-generators/systemd-system-update-generator
#${RM} lib/systemd/system-generators/systemd-debug-generator
${RM} lib/systemd/system-generators/systemd-getty-generator
${RM} lib/systemd/system-generators/systemd-gpt-auto-generator
#${RM} usr/bin/systemd-analyze
find lib/systemd/system -type f -exec chmod -x "{}" \;
${RM} -r tmp/*
${RM} var/tmp
#${RM} -f var/log
${RM} var/cache
${RM} var/spool
${RM} usr/lib/tmpfiles.d/home.conf
${RM} usr/lib/tmpfiles.d/journal-nocow.conf
${RM} usr/lib/tmpfiles.d/systemd-remote.conf
${RM} usr/lib/tmpfiles.d/systemd-nspawn.conf
${RM} usr/lib/tmpfiles.d/x11.conf
#works when run before masks, but still returns an error code
systemctl --root=. preset-all || :
systemctl --root=. mask systemd-update-done.service
systemctl --root=. mask ldconfig.service
systemctl --root=. mask systemd-sysusers.service
systemctl --root=. mask systemd-timesyncd.service
systemctl --root=. mask systemd-random-seed.service
systemctl --root=. mask systemd-vconsole-setup.service
systemctl --root=. mask systemd-journal-flush.service
systemctl --root=. mask systemd-journal-catalog-update.service
systemctl --root=. mask systemd-ask-password-console.service
systemctl --root=. mask systemd-ask-password-wall.service
systemctl --root=. mask dev-hugepages.mount
systemctl --root=. mask dev-mqueue.mount
systemctl --root=. mask sys-kernel-config.mount
#systemctl --root=. mask sys-kernel-debug.mount
systemctl --root=. mask remote-fs.mount
systemctl --root=. mask swap.mount

#${RM} usr/bin/systemd-cgls
${RM} usr/bin/systemd-cgtop
${RM} usr/bin/systemd-detect-virt
${RM} usr/bin/systemd-nspawn
#${RM} usr/bin/systemd-resolve
#${RM} usr/bin/systemd-run
${RM} usr/bin/systemd-stdio-bridge
${RM} usr/bin/systemd-sysusers
${RM} usr/bin/systemd-ask-password
${RM} usr/bin/systemd-tty-ask-password-agent
${RM} usr/lib/systemd/system/systemd-ask-password-wall.path
${RM} usr/lib/systemd/system/multi-user.target.wants/systemd-ask-password-wall.path
${RM} usr/lib/systemd/system/systemd-ask-password-console.path
${RM} usr/lib/systemd/system/sysinit.target.wants/systemd-ask-password-console.path
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

cp /home/esgs/work/iu/private/dropbear_ecdsa_host_key etc/dropbear/
ln -s -r sbin/mount.ntfs-3g sbin/mount.ntfs

exit 0
${RM} -r ../opt
${MKDIR} -p ../opt/itn/lib
${MV} usr/lib/liborc* ../opt/itn/lib/
${MV} usr/lib/libgst* ../opt/itn/lib/
${MV} usr/lib/gstreamer* ../opt/itn/lib/

${MKDIR} -p ../opt/cea/usr/share
${MV} usr/share/mobile-broadband-provider-info ../opt/cea/usr/share/
