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
#include "HXUtil/HXUtil.h"

USING_NS_CC;

NS_HX_BEGIN

HXEngine* HXEngine::_pHXEngine = NULL;

void HXEngine::init() {
    ccBezierConfig bezier;
    bezier.controlPoint_1 = Point(20, 150);
    bezier.controlPoint_2 = Point(200, 30);
    bezier.endPosition = Point(160, 30);
    auto bezierForward = BezierBy::create(3, bezier);
    auto bezierBack = bezierForward->reverse();
    auto rep = RepeatForever::create(Sequence::create( bezierForward, bezierBack, NULL));
    auto sprite = Sprite::create();
    sprite->setPosition(Point(80,160));

    SpriteFrameCache::getInstance()->addSpriteFramesWithFile("100.plist","100.pvr.ccz");
    auto animFrames = Array::createWithCapacity(4);
    for( int i=1;i<4;i++)
    {
        char szName[100] = {0};
        sprintf(szName, "100.%d.png", i);
        SpriteFrame* frame = SpriteFrameCache::getInstance()->getSpriteFrameByName(szName);
        animFrames->addObject(frame);
    }
    auto animation = Animation::createWithSpriteFrames(animFrames, 0.3f);
    // should last 2.8 seconds. And there are 14 frames.
    animation->setDelayPerUnit(0.8f / 4.0f);
    animation->setRestoreOriginalFrame(true);
    auto action = RepeatForever::create(Animate::create(animation));
    sprite->runAction(action);
    _pHXScene->addChild(sprite);
}

void HXEngine::restartLuaEngineSel(float dt) {
    // 清理上一个luaState
    ScriptEngineManager::getInstance()->removeScriptEngine();

    // todo here
    if (startLuaEngine()) {
        printf("HXGame:debug:game OK!\n");
    }
    else {
        printf("HXGmae:debug:game FAILD!\n");
    }
}

int HXEngine::startLuaEngine() {
    FileUtils::getInstance()->addSearchPath("luaScript");
    LuaEngine* pEngine = LuaEngine::getInstance();
    ScriptEngineManager::getInstance()->setScriptEngine(pEngine);
    lua_State* L = pEngine->getLuaStack()->getLuaState();
    tolua_HXModules_open(L);
    return 0==pEngine->executeScriptFile("main.lua");
}

int HXEngine::restartLuaEngine() {
    log("HXEngine::restartLuaEngine begin");

    // 接管script层所有的注册消息和处理,等待下一帧释放完毕
    Director::getInstance()->getScheduler()->scheduleSelector(
        schedule_selector(HXEngine::restartLuaEngineSel),
        HXEngine::getInstance(),0,false);

    log("HXEngine::restartLuaEngine end");
    return 0;
}

NS_HX_END

