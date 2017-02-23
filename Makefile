TARGET = iphone:clang:9.0:9.0
ARCHS = armv7 armv7s arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Goodges

Goodges_FILES  = include/GGPrefsManager.m include/UIColor+Goodges.m
Goodges_FILES += Goodges.xm

Goodges_FRAMEWORKS = UIKit CoreGraphics Foundation QuartzCore

Goodges_CFLAGS += -Iinclude/

Goodges_LIBRARIES = colorpicker applist

include $(THEOS_MAKE_PATH)/tweak.mk

before-all::
	@cp -pf ./control ./layout/DEBIAN/control

after-install::
	install.exec "killall -9 backboardd"

SUBPROJECTS += prefs

include $(THEOS_MAKE_PATH)/aggregate.mk
