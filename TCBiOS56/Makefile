TARGET = iphone:clang:latest:5.0
ARCHS = armv7

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = TCBiOS56
TCBiOS56_FILES = Tweak.xm
TCBiOS56_FRAMEWORKS = UIKit
TCBiOS56_EXTRA_FRAMEWORKS = CydiaSubstrate
TCBiOS56_INSTALL_PATH = /Library/Application Support/TCB

include $(THEOS_MAKE_PATH)/library.mk
