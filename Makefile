BUILDROOT_DIR = buildroot
BR2_EXTERNAL := $(PWD)
BUILD_DIR = build
BR_MAKE = $(MAKE) -C $(BUILDROOT_DIR) O=$(PWD)/$(BUILD_DIR) BR2_EXTERNAL=$(BR2_EXTERNAL)

.PHONY: all clean menuconfig build

all: build

$(BUILDROOT_DIR):
	git submodule update --init

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

build: $(BUILDROOT_DIR) $(BUILD_DIR)
	$(BR_MAKE) pspl_cms_pi4_defconfig
	$(BR_MAKE)

menuconfig: $(BUILD_DIR)
	$(BR_MAKE) menuconfig

clean:
	rm -rf $(BUILD_DIR)