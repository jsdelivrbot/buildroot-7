################################################################################
#
# diagd
#
################################################################################

DIAGD_VERSION = master
DIAGD_SITE = https://git.mod.agcocorp.com/git/Diagnostics/diagd.git
DIAGD_SITE = /home/esgs/work/git/diagd
DIAGD_SITE_METHOD = git
DIAGD_SITE_METHOD = local
DIAGD_LICENSE = Proprietary
DIAGD_LICENSE_FILES = LICENSE
DIAGD_CONF_OPTS = # -DCONFIG_DIAGBUS

ifeq ($(BR2_PACKAGE_DIAGD_DEVELMODE),y)
DIAGD_CONF_OPTS += -DCONFIG_DEVELMODE=ON
endif

ifeq ($(BR2_PACKAGE_DIAGD_TARGET_DASH),y)
DIAGD_CONF_OPTS += -DTARGET_PLATFORM=DASH
else ifeq ($(BR2_PACKAGE_DIAGD_TARGET_DCU),y)
DIAGD_CONF_OPTS += -DTARGET_PLATFORM=DCU
else ifeq ($(BR2_PACKAGE_DIAGD_TARGET_IU),y)
DIAGD_CONF_OPTS += -DTARGET_PLATFORM=IU
else
DIAGD_CONF_OPTS += -DTARGET_PLATFORM=HOST
endif

ifeq ($(BR2_PACKAGE_DIAGD_DEM),y)
DIAGD_CONF_OPTS += -DCONFIG_DEM=ON
endif

ifeq ($(BR2_PACKAGE_DIAGD_DIAGBUS),y)
DIAGD_CONF_OPTS += -DCONFIG_DIAGBUS=ON
endif

$(eval $(cmake-package))
