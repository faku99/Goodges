TARGET = iphone:clang:9.0:9.0
ARCHS = armv7 armv7s arm64

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = GoodgesPrefs

GoodgesPrefs_FILES  = ../include/GGPrefsManager.m ../include/UIColor+Goodges.m
GoodgesPrefs_FILES += GGAdvancedListController.m GGAppDetailsViewController.m GGColorPickerCell.m GGCreditsListController.m GGDeveloperCell.m GGRootListController.m

GoodgesPrefs_FRAMEWORKS = MessageUI Social UIKit
GoodgesPrefs_PRIVATE_FRAMEWORKS = Preferences

GoodgesPrefs_LIBRARIES = colorpicker applist

GoodgesPrefs_INSTALL_PATH = /Library/PreferenceBundles

GoodgesPrefs_CFLAGS += -I../include -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/GoodgesPrefs.plist$(ECHO_END)
