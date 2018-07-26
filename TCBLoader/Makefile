ifeq ($(SIMULATOR),1)
	TARGET = simulator:clang:latest
	ARCHS = x86_64 i386
else
	TARGET = iphone:clang:11.2:5.0
endif

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TransparentCameraBar
TransparentCameraBar_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

ifeq ($(SIMULATOR),1)
SIM_TARGET := TCBiOS10
all::
	@rm -f /opt/simject/$(SIM_TARGET).dylib
	@cp -v $(THEOS_OBJ_DIR)/$(SIM_TARGET).dylib /opt/simject
	@cp -v $(PWD)/$(TWEAK_NAME).plist /opt/simject/$(SIM_TARGET).plist
endif