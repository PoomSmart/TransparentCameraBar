PACKAGE_VERSION = 1.8

include $(THEOS)/makefiles/common.mk

AGGREGATE_NAME = TCB
SUBPROJECTS = TCBiOS8 TCBiOS9 TCBiOS10 TCBSettings TCBLoader
ifneq ($(SIMULATOR),1)
	SUBPROJECTS += TCBiOS56 TCBiOS7
endif

include $(THEOS_MAKE_PATH)/aggregate.mk

ifneq ($(SIMULATOR),1)

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp TCBSettings/entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/TransparentCameraBar.plist$(ECHO_END)
	$(ECHO_NOTHING)find $(THEOS_STAGING_DIR) -name .DS_Store | xargs rm -rf$(ECHO_END)
endif
