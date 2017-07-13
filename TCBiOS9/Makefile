ifeq ($(SIMULATOR),1)
	TARGET = simulator:clang:latest
	ARCHS = x86_64 i386
else
	TARGET = iphone:latest:9.0
endif

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = TCBiOS9
TCBiOS9_FILES = Tweak.xm
TCBiOS9_FRAMEWORKS = UIKit
TCBiOS9_INSTALL_PATH = /Library/Application Support/TCB
TCBiOS9_LIBRARIES = substrate

include $(THEOS_MAKE_PATH)/library.mk
