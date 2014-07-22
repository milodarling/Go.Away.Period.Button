TARGET := iphone:clang
ARCHS = armv7 arm64

TWEAK_NAME = GoAwayPeriodButtonChrome
GoAwayPeriodButtonChrome_CFLAGS = -fobjc-arc
GoAwayPeriodButtonChrome_FILES = Tweak.xm
GoAwayPeriodButtonChrome_FRAMEWORKS = Foundation UIKit

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 backboardd"
