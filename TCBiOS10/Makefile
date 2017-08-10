ifeq ($(SIMULATOR),1)
	TARGET = simulator:clang:latest
	ARCHS = x86_64 i386
else
	TARGET = iphone:clang:latest:9.0
endif

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = TCBiOS10
TCBiOS10_FILES = Tweak.xm
TCBiOS10_FRAMEWORKS = UIKit
TCBiOS10_EXTRA_FRAMEWORKS = CydiaSubstrate
TCBiOS10_INSTALL_PATH = /Library/MobileSubstrate/DynamicLibraries/TCB

include $(THEOS_MAKE_PATH)/library.mk
