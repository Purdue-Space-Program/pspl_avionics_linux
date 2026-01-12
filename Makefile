BUILDROOT_DIR = buildroot
BUILD_DIR = outputs
CACHE_DIR = cache
BR2_EXTERNAL := $(PWD)/buildroot-external
BR_MAKE_OPTS = -C $(BUILDROOT_DIR) O=$(PWD)/$(BUILD_DIR) BR2_EXTERNAL=$(BR2_EXTERNAL) BR2_CCACHE_DIR=$(PWD)/$(CACHE_DIR)
TARGET ?= cms

ifeq ($(TARGET),cms)
DEFCONFIG = pspl_cms_pi4_defconfig
else ifeq ($(TARGET),cph)
DEFCONFIG = pspl_cph_pi4_defconfig
else
$(error Unknown TARGET '$(TARGET)'. Use cms or cph.)
endif

.PHONY: all build config clean

all: build

$(BUILDROOT_DIR):
	git submodule update --init

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(CACHE_DIR):
	mkdir -p $(CACHE_DIR)

build: $(BUILDROOT_DIR) $(BUILD_DIR) $(CACHE_DIR) config
	$(MAKE) $(BR_MAKE_OPTS) -j$(shell nproc)

config: $(BUILDROOT_DIR) $(BUILD_DIR) $(CACHE_DIR)
	$(MAKE) $(BR_MAKE_OPTS) $(DEFCONFIG)

clean: $(BUILDROOT_DIR) $(BUILD_DIR) $(CACHE_DIR)
	$(MAKE) $(BR_MAKE_OPTS) clean

br-%: $(BUILDROOT_DIR) $(BUILD_DIR) $(CACHE_DIR)
	$(MAKE) $(BR_MAKE_OPTS) $*
