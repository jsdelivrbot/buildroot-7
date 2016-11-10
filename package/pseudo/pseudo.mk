################################################################################
#
# pseudo
#
################################################################################

PSEUDO_VERSION = 45eca34c754d416a38bee90fb2d3c110a0b6cc5f
PSEUDO_SITE = https://git.yoctoproject.org/git/pseudo
PSEUDO_SITE_METHOD = git

# No "or later" clause.
PSEUDO_LICENSE = LGPLv2.1
PSEUDO_LICENSE_FILES = COPYING

HOST_PSEUDO_DEPENDENCIES = host-attr host-sqlite

# configure script is not generated by autoconf, so passing --libdir
# is necessary, even if the infrastructure passes --prefix already.
# It also does not use CFLAGS from the environment, they need to be
# specified with a custom --cflags option. Also force rpath to avoid
# a warning at configure time.
HOST_PSEUDO_CONF_OPTS = \
	--cflags="$(HOSTCFLAGS)" \
	--with-rpath=$(HOST_DIR)/usr/lib \
	--bits=$(if $(filter %64,$(HOSTARCH)),64,32) \
	--libdir=$(HOST_DIR)/usr/lib \
	--with-sqlite=$(HOST_DIR)/usr

define HOST_PSEUDO_INSTALL_WRAPPER
	$(INSTALL) -D -m 0755 $(HOST_PSEUDO_PKGDIR)/pseudo-wrapper \
		$(HOST_DIR)/usr/bin/pseudo-wrapper
endef
HOST_PSEUDO_POST_INSTALL_HOOKS += HOST_PSEUDO_INSTALL_WRAPPER

define HOST_PSEUDO_FAKEROOT_SYMLINK
	ln -sf pseudo-wrapper $(HOST_DIR)/usr/bin/fakeroot
endef
HOST_PSEUDO_POST_INSTALL_HOOKS += HOST_PSEUDO_FAKEROOT_SYMLINK

$(eval $(host-autotools-package))
