LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE	:= hxmodules_static

LOCAL_MODULE_FILENAME := libhxmodules

LOCAL_SRC_FILES := ../HXEngine/HXEngine.cpp \
	../HXUtil/HXUtil.cpp \
	../HXLuaModules.cpp

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/.. \
						   $(LOCAL_PATH)/../HXEngine

LOCAL_C_INCLUDES := $(LOCAL_PATH)/ \
					$(LOCAL_PATH)/../ \
					$(LOCAL_PATH)/../HXEngine \
					$(LOCAL_PATH)/../HXUtil \

LOCAL_WHOLE_STATIC_LIBRARIES := cocos2dx_static
LOCAL_WHOLE_STATIC_LIBRARIES += cocosdenshion_static
LOCAL_WHOLE_STATIC_LIBRARIES += cocos_lua_static
LOCAL_WHOLE_STATIC_LIBRARIES += cocos_extension_static
LOCAL_WHOLE_STATIC_LIBRARIES += cocos2dxandroid_static

LOCAL_CFLAGS += -Wno-psabi
LOCAL_EXPORT_CFLAGS += -Wno-psabi

include $(BUILD_STATIC_LIBRARY)

