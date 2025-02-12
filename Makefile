BUILDROOT_DIR = buildroot
BR2_EXTERNAL := $(PWD)/br-ext-pspl-cms
BUILD_DIR = outputs
BR_MAKE_OPTS = -C $(BUILDROOT_DIR) O=$(PWD)/$(BUILD_DIR) BR2_EXTERNAL=$(BR2_EXTERNAL)

.PHONY: all clean config menuconfig build

all: build

$(BUILDROOT_DIR):
	git submodule update --init

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
	mkdir -p cache

build: $(BUILDROOT_DIR) $(BUILD_DIR)
	$(MAKE) $(BR_MAKE_OPTS)

config: $(BUILDROOT_DIR) $(BUILD_DIR)
	$(MAKE) $(BR_MAKE_OPTS) pspl_cms_pi4_defconfig

menuconfig: $(BUILDROOT_DIR) $(BUILD_DIR)
	$(MAKE) $(BR_MAKE_OPTS) menuconfig

linux-menuconfig: $(BUILDROOT_DIR) $(BUILD_DIR)
	$(MAKE) $(BR_MAKE_OPTS) linux-menuconfig

br-%: $(BUILDROOT_DIR) $(BUILD_DIR)
	$(MAKE) $(BR_MAKE_OPTS) $*
