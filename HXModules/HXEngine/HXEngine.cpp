/*=============================================================================
#     FileName: HXEngine.cpp
#         Desc: engine system
#       Author: hanxi
#        Email: hanxi.com@gmail.com
#     HomePage: http://hanxi.cnblogs.com
#      Version: 0.0.1
#   LastChange: 2013-09-29 14:05:42
#      History:
=============================================================================*/
#include "HXEngine.h"
#include "script_support/CCScriptSupport.h"
#include "CCLuaEngine.h"
#include "HXLuaModules.h"

#include <iostream>
using namespace std;

USING_NS_CC;

void HXLuaEngine::restart(float) {
    // 清理上一个luaState
    ScriptEngineManager::getInstance()->removeScriptEngine();

    // 重新生成luaState
    LuaEngine* pEngine = LuaEngine::defaultEngine();
    ScriptEngineManager::getInstance()->setScriptEngine(pEngine);

    // todo here
    if (HXLuaEngine::execute()) {
        printf("HXGame:debug:game OK!\n");
    }
    else {
        printf("HXGmae:debug:game FAILD!\n");
    }
}

int HXLuaEngine::execute() {
    FileUtils::getInstance()->addSearchPath("luaScript");
    LuaEngine* pEngine = LuaEngine::getInstance();
    ScriptEngineManager::getInstance()->setScriptEngine(pEngine);
    lua_State* L = pEngine->getLuaStack()->getLuaState();
    tolua_HXModules_open(L);
    return 0==pEngine->executeScriptFile("main.lua");
}

int capi_restartLuaEngine() {
    cout << "capi_restartLuaEngine" << endl;
    //1. 切换到空的Scene
    Scene* pScene = Scene::create();
    Director::getInstance()->pushScene(pScene);

    //2. 接管script层所有的注册消息和处理,等待下一帧释放完毕
    HXLuaEngine *obj = new HXLuaEngine();
    obj->retain();
    Director::getInstance()->getScheduler()->scheduleSelector(
        schedule_selector(HXLuaEngine::restart),
        obj,0,false,0,1);
    obj->release();
    return 0;
}

