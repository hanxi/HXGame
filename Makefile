PLATFORM ?= linux

define MAKE_TARGETS
	+$(MAKE) -C libs/external/chipmunk/proj.$(PLATFORM) $@
	+$(MAKE) -C libs/external/Box2D/proj.$(PLATFORM) $@
	+$(MAKE) -C libs/CocosDenshion/proj.$(PLATFORM) $@
	+$(MAKE) -C libs/extensions/proj.$(PLATFORM) $@
	+$(MAKE) -C libs/cocos2dx/proj.$(PLATFORM) $@
	+$(MAKE) -C libs/scripting/lua/proj.$(PLATFORM) $@
	+$(MAKE) -C HXModules/proj.$(PLATFORM) $@
	+$(MAKE) -C proj.$(PLATFORM) $@
endef

all:
	$(call MAKE_TARGETS,all)

clean:
	$(call MAKE_TARGETS,clean)

.PHONY: all clean
