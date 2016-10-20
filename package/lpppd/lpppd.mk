################################################################################
#
# lpppd
#
################################################################################

LPPPD_VERSION = 1
#LPPPD_SOURCE = lppp-$(LPPPD_VERSION).tar.gz
#LPPPD_SITE = https://download.samba.org/pub/ppp
LPPPD_SITE = $(HOME)/git/ppp
LPPPD_SITE_METHOD = local
LPPPD_LICENSE = LGPLv2+, LGPL, BSD-4c, BSD-3c, GPLv2+
LPPPD_LICENSE_FILES = \
	pppd/tdb.c pppd/plugins/pppoatm/COPYING \
	pppdump/bsd-comp.c pppd/ccp.c pppd/plugins/passprompt.c

LPPPD_CONF_OPTS = -DPPPD_INET6=ON
#LPPPD_INSTALL_STAGING = YES
LPPPD_TARGET_BINS = chat pppd pppdump pppstats
LPPPD_RADIUS_CONF = \
	dictionary dictionary.ascend dictionary.compat \
	dictionary.merit dictionary.microsoft \
	issue port-id-map realms server radiusclient.conf

ifeq ($(BR2_PACKAGE_LPPPD_FILTER),y)
LPPPD_DEPENDENCIES += libpcap
LPPPD_CONF_OPTS += -DPPPD_FILTER=ON
endif

ifeq ($(BR2_PACKAGE_LPPPD_MULTILINKTDB),y)
LPPPD_CONF_OPTS += -DPPPD_MULTILINK=ON
endif

# pppd bundles some but not all of the needed kernel headers. The embedded
# if_pppol2tp.h is unfortunately not compatible with kernel headers > 2.6.34,
# and has been part of the kernel headers since 2.6.23, so drop it
define LPPPD_DROP_INTERNAL_IF_PPOL2TP_H
	$(RM) $(@D)/include/linux/if_pppol2tp.h
endef

LPPPD_POST_EXTRACT_HOOKS += LPPPD_DROP_INTERNAL_IF_PPOL2TP_H

# pppd defaults to /etc/ppp/resolv.conf, which not be writable and is
# definitely not useful since the C library only uses
# /etc/resolv.conf. Therefore, we change pppd to use /etc/resolv.conf
# instead.
define LPPPD_SET_RESOLV_CONF
	$(SED) 's,ppp/resolv.conf,resolv.conf,' $(@D)/pppd/pathnames.h
endef
LPPPD_POST_EXTRACT_HOOKS += LPPPD_SET_RESOLV_CONF

ifeq ($(BR2_PACKAGE_LPPPD_RADIUS),y)
define LPPPD_INSTALL_RADIUS
	$(INSTALL) -D $(LPPPD_DIR)/pppd/plugins/radius/radattr.so \
		$(TARGET_DIR)/usr/lib/pppd/$(LPPPD_VERSION)/radattr.so
	$(INSTALL) -D $(LPPPD_DIR)/pppd/plugins/radius/radius.so \
		$(TARGET_DIR)/usr/lib/pppd/$(LPPPD_VERSION)/radius.so
	$(INSTALL) -D $(LPPPD_DIR)/pppd/plugins/radius/radrealms.so \
		$(TARGET_DIR)/usr/lib/pppd/$(LPPPD_VERSION)/radrealms.so
	for m in $(LPPPD_RADIUS_CONF); do \
		$(INSTALL) -m 644 -D $(LPPPD_DIR)/pppd/plugins/radius/etc/$$m \
			$(TARGET_DIR)/etc/ppp/radius/$$m; \
	done
	$(SED) 's:/usr/local/etc:/etc:' \
		$(TARGET_DIR)/etc/ppp/radius/radiusclient.conf
	$(SED) 's:/usr/local/sbin:/usr/sbin:' \
		$(TARGET_DIR)/etc/ppp/radius/radiusclient.conf
	$(SED) 's:/etc/radiusclient:/etc/ppp/radius:g' \
		$(TARGET_DIR)/etc/ppp/radius/*
endef
endif

ifeq ($(BR2_PACKAGE_LPPPD_PLUGINS),y)
define LPPPD_INSTALL_PLUGINS
	$(INSTALL) -D $(LPPPD_DIR)/pppd/plugins/minconn.so \
		$(TARGET_DIR)/usr/lib/pppd/$(LPPPD_VERSION)/minconn.so
	$(INSTALL) -D $(LPPPD_DIR)/pppd/plugins/passprompt.so \
		$(TARGET_DIR)/usr/lib/pppd/$(LPPPD_VERSION)/passprompt.so
	$(INSTALL) -D $(LPPPD_DIR)/pppd/plugins/passwordfd.so \
		$(TARGET_DIR)/usr/lib/pppd/$(LPPPD_VERSION)/passwordfd.so
	$(INSTALL) -D $(LPPPD_DIR)/pppd/plugins/pppoatm/pppoatm.so \
		$(TARGET_DIR)/usr/lib/pppd/$(LPPPD_VERSION)/pppoatm.so
	$(INSTALL) -D $(LPPPD_DIR)/pppd/plugins/pppol2tp/openl2tp.so \
		$(TARGET_DIR)/usr/lib/pppd/$(LPPPD_VERSION)/openl2tp.so
	$(INSTALL) -D $(LPPPD_DIR)/pppd/plugins/pppol2tp/pppol2tp.so \
		$(TARGET_DIR)/usr/lib/pppd/$(LPPPD_VERSION)/pppol2tp.so
	$(LPPPD_INSTALL_RADIUS)
endef
endif

define LPPPD_INSTALL_TARGET_CMDS
	for sbin in $(LPPPD_TARGET_BINS); do \
		$(INSTALL) -D $(LPPPD_DIR)/$$sbin/$$sbin \
			$(TARGET_DIR)/usr/sbin/$$sbin; \
	done
	$(INSTALL) -D -m 0755 $(LPPPD_DIR)/scripts/pon $(TARGET_DIR)/usr/bin/pon
	$(INSTALL) -D -m 0755 $(LPPPD_DIR)/scripts/poff $(TARGET_DIR)/usr/bin/poff
	$(LPPPD_INSTALL_PLUGINS)
endef

#define LPPPD_INSTALL_STAGING_CMDS
#	$(MAKE) INSTROOT=$(STAGING_DIR)/ -C $(@D) $(LPPPD_CONF_OPTS) install-devel
#endef

$(eval $(cmake-package))
