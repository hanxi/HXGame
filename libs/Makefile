PLATFORM ?= linux

all:

chipmunk:
	$(MAKE) -C external/chipmunk/proj.$(PLATFORM)
chipmunk-clean:
	$(MAKE) -C external/chipmunk/proj.$(PLATFORM) clean

box2d:
	$(MAKE) -C external/Box2D/proj.$(PLATFORM)
box2d-clean:
	$(MAKE) -C external/Box2D/proj.$(PLATFORM) clean

libextensions: cocosdenshion chipmunk box2d
	$(MAKE) -C extensions/proj.$(PLATFORM)
libextensions-clean:
	$(MAKE) -C extensions/proj.$(PLATFORM) clean

libcocos2dx: libextensions
	$(MAKE) -C cocos2dx/proj.$(PLATFORM)
libcocos2dx-clean:
	$(MAKE) -C cocos2dx/proj.$(PLATFORM) clean

cocosdenshion: libcocos2dx
	$(MAKE) -C CocosDenshion/proj.$(PLATFORM)
cocosdenshion-clean:
	$(MAKE) -C CocosDenshion/proj.$(PLATFORM) clean

lua: libextensions
	$(MAKE) -C scripting/lua/proj.$(PLATFORM)
lua-clean:
	$(MAKE) -C scripting/lua/proj.$(PLATFORM) clean

all: box2d cocosdenshion libextensions libcocos2dx lua
clean: libcocos2dx-clean box2d-clean chipmunk-clean cocosdenshion-clean libextensions-clean lua-clean

.PHONY: all clean
