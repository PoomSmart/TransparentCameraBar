DEBUG = 0
SIMULATOR = 0
PACKAGE_VERSION = 1.7.5

ifeq ($(SIMULATOR),1)
	TARGET = simulator:clang:latest
	ARCHS = x86_64 i386
endif

include $(THEOS)/makefiles/common.mk

AGGREGATE_NAME = TCB
SUBPROJECTS = TCBiOS8 TCBiOS9 TCBiOS10
ifeq ($(SIMULATOR),0)
	SUBPROJECTS += TCBiOS56 TCBiOS7
endif

include $(THEOS_MAKE_PATH)/aggregate.mk

TWEAK_NAME = TransparentCameraBar
ifeq ($(SIMULATOR),0)
TransparentCameraBar_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

BUNDLE_NAME = TransparentCameraBarSettings
TransparentCameraBarSettings_FILES = TCBPreferenceController.m
TransparentCameraBarSettings_INSTALL_PATH = /Library/PreferenceBundles
TransparentCameraBarSettings_PRIVATE_FRAMEWORKS = Preferences
TransparentCameraBarSettings_FRAMEWORKS = CoreGraphics Social UIKit
TransparentCameraBarSettings_LIBRARIES = cepheiprefs

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/TransparentCameraBar.plist$(ECHO_END)
	$(ECHO_NOTHING)find $(THEOS_STAGING_DIR) -name .DS_Store | xargs rm -rf$(ECHO_END)
endif

SIM_TARGET = TCBiOS10
all::
ifeq ($(SIMULATOR),1)
	@rm -f /opt/simject/$(SIM_TARGET).dylib
	@cp -v $(THEOS_OBJ_DIR)/$(SIM_TARGET).dylib /opt/simject
	@cp -v $(PWD)/$(TWEAK_NAME).plist /opt/simject/$(SIM_TARGET).plist
endif
