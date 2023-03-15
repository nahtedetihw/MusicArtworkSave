TARGET := iphone:clang:latest:13.0
INSTALL_TARGET_PROCESSES = Music

DEBUG=0
FINALPACKAGE=1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MusicArtworkSave

MusicArtworkSave_FILES = Tweak.xm
MusicArtworkSave_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
