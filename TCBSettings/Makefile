ifeq ($(SIMULATOR),1)
	TARGET = simulator:clang:latest
	ARCHS = x86_64 i386
else
	TARGET = iphone:clang:11.2:5.0
endif

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = TransparentCameraBarSettings
TransparentCameraBarSettings_FILES = TCBPreferenceController.m
TransparentCameraBarSettings_INSTALL_PATH = /Library/PreferenceBundles
TransparentCameraBarSettings_PRIVATE_FRAMEWORKS = Preferences
TransparentCameraBarSettings_EXTRA_FRAMEWORKS = CepheiPrefs
TransparentCameraBarSettings_FRAMEWORKS = CoreGraphics Social UIKit
TransparentCameraBarSettings_LDFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
