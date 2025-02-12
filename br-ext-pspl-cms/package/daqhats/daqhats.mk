################################################################################
#
# daqhats
#
################################################################################

DAQHATS_VERSION = 1.5.0.0
DAQHATS_SITE = $(call github,mccdaq,daqhats,v$(DAQHATS_VERSION))
DAQHATS_LICENSE = MIT
DAQHATS_LICENSE_FILES = LICENSE.txt
DAQHATS_INSTALL_STAGING = YES
DAQHATS_DEPENDENCIES = libgpiod

define DAQHATS_BUILD_CMDS
	# Build the library
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/lib \
		CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS) -I../include -fPIC -Wall -Wextra -DENABLE_LOCALES=Off" \
		LDFLAGS="-shared -pthread -Wl,-soname,libdaqhats.so.1" \
		DEPLIBS="-lm -lgpiod" \
		BUILD_DIR="./build" \
		all
endef

# Install library first so tools can find it
define DAQHATS_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(STAGING_DIR)/usr/include/daqhats
	$(INSTALL) -m 644 $(@D)/include/*.h $(STAGING_DIR)/usr/include/daqhats
	$(INSTALL) -d $(STAGING_DIR)/usr/lib
	$(INSTALL) -m 755 $(@D)/lib/build/libdaqhats.so.$(DAQHATS_VERSION) $(STAGING_DIR)/usr/lib
	ln -sf libdaqhats.so.$(DAQHATS_VERSION) $(STAGING_DIR)/usr/lib/libdaqhats.so.1
	ln -sf libdaqhats.so.1 $(STAGING_DIR)/usr/lib/libdaqhats.so
endef

# Build tools after library is installed
define DAQHATS_BUILD_TOOLS_CMDS
	# Build the tools
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/tools \
		CC="$(TARGET_CC)" \
		INCLUDE_DIR="../include" \
		LIB_DIR="../lib" \
		CFLAGS="$(TARGET_CFLAGS) -I../include -I../lib" \
		LDFLAGS="-L$(@D)/lib/build" \
		OFLAGS="-ldaqhats" \
		mcc118_firmware_update \
		mcc172_firmware_update \
		mcc128_firmware_update \
		daqhats_list_boards \
		daqhats_check_152
endef

DAQHATS_POST_INSTALL_STAGING_HOOKS += DAQHATS_BUILD_TOOLS_CMDS

define DAQHATS_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(STAGING_DIR)/usr/include/daqhats
	$(INSTALL) -m 644 $(@D)/include/*.h $(STAGING_DIR)/usr/include/daqhats
	$(INSTALL) -d $(STAGING_DIR)/usr/lib
	$(INSTALL) -m 755 $(@D)/lib/build/libdaqhats.so.$(DAQHATS_VERSION) $(STAGING_DIR)/usr/lib
	ln -sf libdaqhats.so.$(DAQHATS_VERSION) $(STAGING_DIR)/usr/lib/libdaqhats.so.1
	ln -sf libdaqhats.so.1 $(STAGING_DIR)/usr/lib/libdaqhats.so
endef

define DAQHATS_INSTALL_TARGET_CMDS
	# Install the library
	$(INSTALL) -d $(TARGET_DIR)/usr/lib
	$(INSTALL) -m 755 $(@D)/lib/build/libdaqhats.so.$(DAQHATS_VERSION) $(TARGET_DIR)/usr/lib
	ln -sf libdaqhats.so.$(DAQHATS_VERSION) $(TARGET_DIR)/usr/lib/libdaqhats.so.1
	ln -sf libdaqhats.so.1 $(TARGET_DIR)/usr/lib/libdaqhats.so

	# Install the tools
	$(INSTALL) -d $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 755 $(@D)/tools/mcc172_firmware_update $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 755 $(@D)/tools/mcc128_firmware_update $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 755 $(@D)/tools/mcc118_firmware_update $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 755 $(@D)/tools/daqhats_list_boards $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 755 $(@D)/tools/daqhats_check_152 $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))