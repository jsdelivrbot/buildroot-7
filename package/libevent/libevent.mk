################################################################################
#
# libevent
#
################################################################################

LIBEVENT_VERSION = master
LIBEVENT_SITE = https://github.com/libevent/libevent.git
LIBEVENT_SITE_METHOD = git
LIBEVENT_INSTALL_STAGING = YES
LIBEVENT_LICENSE = BSD-3-Clause, OpenBSD
LIBEVENT_LICENSE_FILES = LICENSE
LIBEVENT_AUTORECONF = YES
LIBEVENT_CONF_OPTS = --disable-samples

define LIBEVENT_REMOVE_PYSCRIPT
	rm $(TARGET_DIR)/usr/bin/event_rpcgen.py
endef

# libevent installs a python script to target - get rid of it if we
# don't have python support enabled
ifneq ($(BR2_PACKAGE_PYTHON),y)
LIBEVENT_POST_INSTALL_TARGET_HOOKS += LIBEVENT_REMOVE_PYSCRIPT
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
LIBEVENT_DEPENDENCIES += host-pkgconf openssl
LIBEVENT_CONF_OPTS += --enable-openssl
else
LIBEVENT_CONF_OPTS += --disable-openssl
endif

LIBEVENT_CONF_OPTS += --disable-malloc-replacement --disable-libevent-regress --disable-samples

$(eval $(autotools-package))
$(eval $(host-autotools-package))
