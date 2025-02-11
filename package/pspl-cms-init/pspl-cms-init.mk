################################################################################
#
# psp-cms-init
#
################################################################################

PSP_CMS_INIT_VERSION = 1.0
PSP_CMS_INIT_SITE = $(BR2_EXTERNAL_PSP_CMS_PATH)/package/psp-cms-init/src
PSP_CMS_INIT_SITE_METHOD = local
PSP_CMS_INIT_LICENSE = Proprietary

define PSP_CMS_INIT_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/init $(TARGET_DIR)/sbin/init
endef

$(eval $(generic-package))