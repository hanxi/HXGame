#ifndef _HX_LUA_MODULES_H_
#define _HX_LUA_MODULES_H_

#ifdef __cplusplus
extern "C" {
#endif
#include "tolua++.h"
#ifdef __cplusplus
}
#endif

TOLUA_API int  tolua_HXModules_open (lua_State* tolua_S);

#endif // _HX_LUA_MODULES_H_

