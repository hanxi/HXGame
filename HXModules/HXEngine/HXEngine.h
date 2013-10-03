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
#include "HXMacros.h"

NS_HX_BEGIN

class HXEngine : public cocos2d::Object {
public:
    int startLuaEngine();

    int restartLuaEngine();

    static HXEngine* getInstance() {
        if (!_pHXEngine)
        {
            _pHXEngine = new HXEngine();
        }
        return _pHXEngine;
    }

    static void destroyInstance() {
        CC_SAFE_RELEASE_NULL(_pHXEngine);
    }

    cocos2d::Scene* getScene() const {
        return _pHXScene;
    }
    void init();
    void exitGame() {
        cocos2d::Director::getInstance()->end();
    }

private:
    static HXEngine* _pHXEngine;
    cocos2d::Scene* _pHXScene;

    HXEngine(void) {
        _pHXScene = cocos2d::Scene::create();
    }

    ~HXEngine(void) {
        CC_SAFE_RELEASE_NULL(_pHXScene);
    }
    void restartLuaEngineSel(float dt=0);
};

NS_HX_END
#endif // _HX_ENGINE_H_

