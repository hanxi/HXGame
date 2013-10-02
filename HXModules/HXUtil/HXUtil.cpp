/*=============================================================================
#     FileName: HXUtil.cpp
#         Desc: engine system
#       Author: hanxi
#        Email: hanxi.com@gmail.com
#     HomePage: http://hanxi.cnblogs.com
#      Version: 0.0.1
#   LastChange: 2013-10-02 17:00:35
#      History:
=============================================================================*/
#include "HXUtil.h"

USING_NS_CC;

namespace hx{ namespace hxutil {

long HXMillisecondNow() {
    struct timeval tv;
    gettimeofday(&tv,NULL);
    return tv.tv_sec * 1000 + tv.tv_usec / 1000;
}

RenderTexture* HXSaveScreenToRenderTexture()
{
    Size winSize = Director::getInstance()->getWinSize();
    RenderTexture* render  = RenderTexture::create(winSize.height, winSize.width);

    render->begin();
    Director::getInstance()->drawScene();
    render->end();

    return render;
}

}} // end namespace hx namespace hxutil

