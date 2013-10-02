/*=============================================================================
#     FileName: HXMacros.h
#         Desc: define文件
#       Author: hanxi
#        Email: hanxi.com@gmail.com
#     HomePage: http://hanxi.cnblogs.com
#      Version: 0.0.1
#   LastChange: 2013-10-01 20:17:18
#      History:
=============================================================================*/
#ifndef _HX_MACROS_H_
#define _HX_MACROS_H_

// namespace hx {}
#ifdef __cplusplus
    #define NS_HX_BEGIN                     namespace hx {
    #define NS_HX_END                       }
    #define USING_NS_HX                     using namespace hx
#else
    #define NS_HX_BEGIN
    #define NS_HX_END
    #define USING_NS_HX
#endif

#endif // _HX_MACROS_H_

