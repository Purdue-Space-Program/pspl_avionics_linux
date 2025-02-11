################################################################################
#
# daqhats
#
################################################################################

DAQHATS_VERSION = v1.5.0.0  # Replace with actual version
DAQHATS_SITE = $(call github,mccdaq,daqhats,$(DAQHATS_VERSION))  # Replace with actual repo
DAQHATS_LICENSE = MIT  # Replace with actual license
DAQHATS_LICENSE_FILES = LICENSE  # Replace with actual license file
DAQHATS_DEPENDENCIES = libgpiod libgtk3

define DAQHATS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/lib all
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/tools all
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/examples/c all
endef

define DAQHATS_INSTALL_TARGET_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/lib install DESTDIR=$(TARGET_DIR)
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/tools install DESTDIR=$(TARGET_DIR)

	$(INSTALL) -d $(TARGET_DIR)/usr/share/daqhats/examples
	cp -r $(@D)/examples/c/* $(TARGET_DIR)/usr/share/daqhats/examples/

	$(INSTALL) -d $(TARGET_DIR)/etc/mcc/hats
endef

$(eval $(generic-package))