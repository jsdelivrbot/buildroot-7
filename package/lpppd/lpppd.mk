################################################################################
#
# lpppd
#
################################################################################

LPPPD_VERSION = v1
LPPPD_SITE = $(call github,snickl,lpppd,$(LPPPD_VERSION))
LPPPD_LICENSE = LGPLv2+, LGPL, BSD-4c, BSD-3c, GPLv2+
LPPPD_LICENSE_FILES = \
	pppd/tdb.c pppd/plugins/pppoatm/COPYING \
	pppdump/bsd-comp.c pppd/ccp.c pppd/plugins/passprompt.c

LPPPD_CONF_OPTS = -DOPTION_LPPPD_INET6=ON

ifeq ($(BR2_PACKAGE_LPPPD_FILTER),y)
LPPPD_DEPENDENCIES += libpcap
LPPPD_CONF_OPTS += -DOPTION_LPPPD_PPPD_FILTER=ON
endif

ifeq ($(BR2_PACKAGE_LPPPD_MULTILINK),y)
LPPPD_CONF_OPTS += -DOPTION_LPPPD_PPPD_MULTILINK=ON
endif

define LPPPD_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR="$(TARGET_DIR)" install
	$(INSTALL) -D -m 0755 $(LPPPD_DIR)/scripts/pon $(TARGET_DIR)/usr/bin/pon
	$(INSTALL) -D -m 0755 $(LPPPD_DIR)/scripts/poff $(TARGET_DIR)/usr/bin/poff
endef

$(eval $(cmake-package))
