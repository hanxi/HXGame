/*=============================================================================
#     FileName: HXEngine.h
#         Desc:
#       Author: hanxi
#        Email: hanxi.com@gmail.com
#     HomePage: http://hanxi.cnblogs.com
#      Version: 0.0.1
#   LastChange: 2013-09-29 17:24:27
#      History:
=============================================================================*/
#ifndef _HX_ENGINE_H_
#define _HX_ENGINE_H_

extern "C" {
#include "lua.h"
}

#include "cocos2d.h"

class HXLuaEngine : public cocos2d::Object {
public:
    void restart(float);
    static int execute();

    HXLuaEngine(void)
    {
    }
};

int capi_restartLuaEngine();

#endif // _HX_ENGINE_H_

