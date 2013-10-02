/*=============================================================================
#     FileName: HXUtil.h
#         Desc:
#       Author: hanxi
#        Email: hanxi.com@gmail.com
#     HomePage: http://hanxi.cnblogs.com
#      Version: 0.0.1
#   LastChange: 2013-10-02 17:00:06
#      History:
=============================================================================*/
#ifndef _HX_UTIL_H_
#define _HX_UTIL_H_

#include "cocos2d.h"

namespace hx { namespace hxutil {
    cocos2d::RenderTexture* HXSaveScreenToRenderTexture();
    long HXMillisecondNow();
}}

#endif // _HX_UTIL_H_

