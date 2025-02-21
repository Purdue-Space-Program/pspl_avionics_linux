AVI_FSW_VERSION = 0.1.0
AVI_FSW_SITE = $(call github,Purdue-Space-Program,PSPL_CMS_AVIONICS_COTS_FSW,main)
AVI_FSW_LICENSE = PROPRIETARY
AVI_FSW_DEPENDENCIES = libgpiod daqhats

$(eval $(cmake-package))