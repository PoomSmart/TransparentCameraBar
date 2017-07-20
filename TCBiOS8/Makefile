ifeq ($(SIMULATOR),1)
	TARGET = simulator:clang:latest:8.0
	ARCHS = x86_64 i386
else
	TARGET = iphone:clang:latest:8.0
endif

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = TCBiOS8
TCBiOS8_FILES = Tweak.xm
TCBiOS8_FRAMEWORKS = UIKit
TCBiOS8_EXTRA_FRAMEWORKS = CydiaSubstrate
TCBiOS8_INSTALL_PATH = /Library/Application Support/TCB

include $(THEOS_MAKE_PATH)/library.mk
