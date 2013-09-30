/*
** Lua binding: HXModules
** Generated automatically by tolua++-1.0.92 on Mon Sep 30 01:34:42 2013.
*/

/*=============================================================================
#     FileName: HXLuaModules.cpp
#         Desc: 导出HXModules到lua
#       Author: hanxi
#        Email: hanxi.com@gmail.com
#     HomePage: http://hanxi.cnblogs.com
#      Version: 0.0.1
=============================================================================*/
extern "C" {
#include "tolua_fix.h"
}

#include "HXModules.h"


/* function to register type */
static void tolua_reg_types (lua_State* tolua_S)
{
}

/* function: capi_restartLuaEngine */
#ifndef TOLUA_DISABLE_tolua_HXModules_capi_restartLuaEngine00
static int tolua_HXModules_capi_restartLuaEngine00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isnoobj(tolua_S,1,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   int tolua_ret = (int)  capi_restartLuaEngine();
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'capi_restartLuaEngine'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* Open function */
TOLUA_API int tolua_HXModules_open (lua_State* tolua_S)
{
 tolua_open(tolua_S);
 tolua_reg_types(tolua_S);
 tolua_module(tolua_S,NULL,0);
 tolua_beginmodule(tolua_S,NULL);
  tolua_function(tolua_S,"capi_restartLuaEngine",tolua_HXModules_capi_restartLuaEngine00);
 tolua_endmodule(tolua_S);
 return 1;
}


#if defined(LUA_VERSION_NUM) && LUA_VERSION_NUM >= 501
 TOLUA_API int luaopen_HXModules (lua_State* tolua_S) {
 return tolua_HXModules_open(tolua_S);
};
#endif

