ifeq ($(SIMULATOR),1)
	TARGET = simulator:clang:latest:9.0
	ARCHS = x86_64 i386
else
	TARGET = iphone:clang:9.3:9.0
endif

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = TCBiOS9
TCBiOS9_FILES = Tweak.xm
TCBiOS9_FRAMEWORKS = UIKit
TCBiOS9_EXTRA_FRAMEWORKS = CydiaSubstrate
TCBiOS9_INSTALL_PATH = /Library/MobileSubstrate/DynamicLibraries/TCB

include $(THEOS_MAKE_PATH)/library.mk
