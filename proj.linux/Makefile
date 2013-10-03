EXECUTABLE = HXGame
PLATFORM ?= linux

DEBUG=1

PROJ_ROOT = ..
COCOS_ROOT = ../libs
INCLUDES =	-I../ -I../Classes -I$(COCOS_ROOT)/CocosDenshion/include \
	-I$(COCOS_ROOT)/scripting/lua/lua \
	-I$(COCOS_ROOT)/scripting/lua/tolua \
	-I$(COCOS_ROOT)/scripting/lua/cocos2dx_support \
	-I$(PROJ_ROOT)/HXModules

SOURCES = main.cpp ../Classes/AppDelegate.cpp

SHAREDLIBS += -lcocos2d -lcocosdenshion -llua -lhxmodules
COCOS_LIBS = $(LIB_DIR)/libcocos2d.so \
		$(LIB_DIR)/libcocosdenshion.so \
		$(LIB_DIR)/liblua.so \
		$(LIB_DIR)/libhxmodules.so

include $(COCOS_ROOT)/cocos2dx/proj.linux/cocos2dx.mk

test:
	@echo $(DEFINES)
	@echo $(COCOS_ROOT)/cocos2dx/proj.linux/cocos2dx.mk
hxmodules:
	$(MAKE) -C ../HXModules/proj.$(PLATFORM)

$(TARGET): $(OBJECTS) $(STATICLIBS) $(COCOS_LIBS) $(CORE_MAKEFILE_LIST) hxmodules
	@echo $(PLATFORM)
	@mkdir -p $(@D)
	$(LOG_LINK)$(CXX) $(CXXFLAGS) $(OBJECTS) -o $@ $(SHAREDLIBS) $(STATICLIBS) $(LIBS)

$(OBJ_DIR)/%.o: ../%.cpp $(CORE_MAKEFILE_LIST)
	@mkdir -p $(@D)
	$(LOG_CXX)$(CXX) $(CXXFLAGS) $(INCLUDES) $(DEFINES) $(VISIBILITY) -c $< -o $@

$(OBJ_DIR)/%.o: %.cpp $(CORE_MAKEFILE_LIST)
	@mkdir -p $(@D)
	$(LOG_CXX)$(CXX) $(CXXFLAGS) $(INCLUDES) $(DEFINES) $(VISIBILITY) -c $< -o $@
