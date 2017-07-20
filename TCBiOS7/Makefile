ifeq ($(SIMULATOR),1)
	TARGET = simulator:clang:latest:7.0
	ARCHS = x86_64 i386
else
	TARGET = iphone:clang:latest:7.0
endif

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = TCBiOS7
TCBiOS7_FILES = Tweak.xm
TCBiOS7_FRAMEWORKS = UIKit
TCBiOS7_EXTRA_FRAMEWORKS = CydiaSubstrate
TCBiOS7_INSTALL_PATH = /Library/Application Support/TCB

include $(THEOS_MAKE_PATH)/library.mk
