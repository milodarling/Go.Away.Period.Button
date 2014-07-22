TARGET := iphone:clang
ARCHS = armv7 arm64
THEOS_BUILD_DIR = Packages

TWEAK_NAME = GoAwayPeriodButtonSafari
GoAwayPeriodButtonSafari_CFLAGS = -fobjc-arc
GoAwayPeriodButtonSafari_FILES = Tweak.xm
GoAwayPeriodButtonSafari_FRAMEWORKS = Foundation UIKit

SUBPROJECTS += goawayperiodbutton
SUBPROJECTS += GoAwayPeriodButtonChrome
SUBPROJECTS += GoAwayPeriodButtonMessages

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

# backboardd kills SpringBoard who kills MobileSafari.
after-install::
	install.exec "killall -9 backboardd"
