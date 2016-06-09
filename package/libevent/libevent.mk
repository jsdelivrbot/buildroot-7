################################################################################
#
# libevent
#
################################################################################

LIBEVENT_VERSION = master
LIBEVENT_SITE = https://github.com/libevent/libevent.git
LIBEVENT_SITE_METHOD = git
LIBEVENT_INSTALL_STAGING = YES
LIBEVENT_LICENSE = BSD-3c, OpenBSD
LIBEVENT_LICENSE_FILES = LICENSE
LIBEVENT_AUTORECONF = YES

define LIBEVENT_REMOVE_PYSCRIPT
	rm $(TARGET_DIR)/usr/bin/event_rpcgen.py
endef

# libevent installs a python script to target - get rid of it if we
# don't have python support enabled
ifneq ($(BR2_PACKAGE_PYTHON),y)
LIBEVENT_POST_INSTALL_TARGET_HOOKS += LIBEVENT_REMOVE_PYSCRIPT
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
LIBEVENT_DEPENDENCIES += openssl
LIBEVENT_CONF_OPTS += --enable-openssl
# openssl needs zlib but configure forgets to link against it causing
# openssl detection to fail
ifeq ($(BR2_STATIC_LIBS),y)
LIBEVENT_CONF_ENV += OPENSSL_LIBADD='-lz'
endif
else
LIBEVENT_CONF_OPTS += --disable-openssl
endif

LIBEVENT_CONF_OPTS += --disable-malloc-replacement --disable-samples

$(eval $(autotools-package))
$(eval $(host-autotools-package))
