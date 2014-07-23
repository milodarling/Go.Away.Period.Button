TARGET := iphone:clang
ARCHS = armv7 arm64
THEOS_BUILD_DIR = Packages

TWEAK_NAME = GoAwayPeriodButtonChrome
GoAwayPeriodButtonChrome_CFLAGS = -fobjc-arc
GoAwayPeriodButtonChrome_FILES = Tweak.xm
GoAwayPeriodButtonChrome_FRAMEWORKS = Foundation UIKit

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
