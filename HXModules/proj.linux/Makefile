TARGET = libhxmodules.so
PLATFORM ?= linux

DEBUG=1

COCOS_ROOT = ../../libs
PROJ_ROOT = ../..
INCLUDES += \
	-I.. \
	-I../HXEngine \
	-I$(COCOS_ROOT) \
	-I$(COCOS_ROOT)/CocosDenshion/include \
	-I$(COCOS_ROOT)/scripting/lua/lua \
	-I$(COCOS_ROOT)/scripting/lua/tolua \
	-I$(COCOS_ROOT)/scripting/lua/cocos2dx_support \
	-I$(PROJ_ROOT)/HXModules


SOURCES = ../HXEngine/HXEngine.cpp \
	../HXUtil/HXUtil.cpp \
	../HXLuaModules.cpp

SHAREDLIBS += -lcocos2d -lcocosdenshion -llua
COCOS_LIBS = $(LIB_DIR)/libcocos2d.so $(LIB_DIR)/libcocosdenshion.so $(LIB_DIR)/liblua.so


CXXFLAGS += -Wno-sequence-point
CCFLAGS += -Wno-sequence-point

include $(COCOS_ROOT)/cocos2dx/proj.linux/cocos2dx.mk

TARGET := $(LIB_DIR)/$(TARGET)

all: $(TARGET)

test:
	@echo $(LIBS)
	@echo $(SHAREDLIBS)
	@echo $(STATICLIBS)

#$(TARGET): $(OBJECTS) $(CORE_MAKEFILE_LIST)
$(TARGET): $(OBJECTS) $(STATICLIBS) $(COCOS_LIBS) $(CORE_MAKEFILE_LIST)
	@mkdir -p $(@D)
	$(LOG_LINK)$(CXX) $(CXXFLAGS) $(OBJECTS) -shared -o $@ $(SHAREDLIBS) $(STATICLIBS) $(LIBS)

$(OBJ_DIR)/%.o: ../%.cpp $(CORE_MAKEFILE_LIST)
	@mkdir -p $(@D)
	$(LOG_CXX)$(CXX) $(CXXFLAGS) $(INCLUDES) $(DEFINES) -c $< -o $@

$(OBJ_DIR)/%.o: ../%.c $(CORE_MAKEFILE_LIST)
	@mkdir -p $(@D)
	$(LOG_CC)$(CC) $(CCFLAGS) $(INCLUDES) $(DEFINES) -c $< -o $@
