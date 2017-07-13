ifeq ($(SIMULATOR),1)
	TARGET = simulator:clang:latest
	ARCHS = x86_64 i386
else
	TARGET = iphone:latest:8.0
endif

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = TCBiOS8
TCBiOS8_FILES = Tweak.xm
TCBiOS8_FRAMEWORKS = UIKit
TCBiOS8_INSTALL_PATH = /Library/Application Support/TCB
TCBiOS8_LIBRARIES = substrate

include $(THEOS_MAKE_PATH)/library.mk
