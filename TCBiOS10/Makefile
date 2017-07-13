ifeq ($(SIMULATOR),1)
	TARGET = simulator:clang:latest
	ARCHS = x86_64 i386
endif

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = TCBiOS10
TCBiOS10_FILES = Tweak.xm
TCBiOS10_FRAMEWORKS = UIKit
TCBiOS10_INSTALL_PATH = /Library/Application Support/TCB
TCBiOS10_LIBRARIES = substrate

include $(THEOS_MAKE_PATH)/library.mk
