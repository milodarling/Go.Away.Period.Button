TARGET := iphone:clang
ARCHS = armv7 arm64
THEOS_BUILD_DIR = Packages

BUNDLE_NAME = GoAwayPeriodButtonSettings
GoAwayPeriodButtonSettings_CFLAGS = -fobjc-arc
GoAwayPeriodButtonSettings_FILES = GoAwayPeriodButtonSettings.mm
GoAwayPeriodButtonSettings_INSTALL_PATH = /Library/PreferenceBundles
GoAwayPeriodButtonSettings_FRAMEWORKS = Foundation UIKit
GoAwayPeriodButtonSettings_PRIVATE_FRAMEWORKS = Preferences

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/GoAwayPeriodButtonSettings.plist$(ECHO_END)
