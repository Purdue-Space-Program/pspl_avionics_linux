BUILDROOT_DIR = buildroot
BUILD_DIR = outputs
CACHE_DIR = cache
BR2_EXTERNAL := $(PWD)/buildroot-external
BR_MAKE_OPTS = -C $(BUILDROOT_DIR) O=$(PWD)/$(BUILD_DIR) BR2_EXTERNAL=$(BR2_EXTERNAL)

.PHONY: all build

all: build

$(BUILDROOT_DIR):
	git submodule update --init

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(CACHE_DIR):
	mkdir -p $(CACHE_DIR)

build: $(BUILDROOT_DIR) $(BUILD_DIR) $(CACHE_DIR)
	$(MAKE) $(BR_MAKE_OPTS) pspl_cms_pi4_defconfig
	$(MAKE) $(BR_MAKE_OPTS)

br-%: $(BUILDROOT_DIR) $(BUILD_DIR) $(CACHE_DIR)
	$(MAKE) $(BR_MAKE_OPTS) $*
