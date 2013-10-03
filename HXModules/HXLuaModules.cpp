/*
** Lua binding: HXModules
** Generated automatically by tolua++-1.0.92 on Fri Oct  4 03:15:22 2013.
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
using namespace hx;
using namespace hxutil;
using namespace cocos2d;


/* function to register type */
static void tolua_reg_types (lua_State* tolua_S)
{
 tolua_usertype(tolua_S,"CCRenderTexture");
 tolua_usertype(tolua_S,"HXEngine");
 tolua_usertype(tolua_S,"CCScene");
 tolua_usertype(tolua_S,"CCObject");
}

/* function: HXMillisecondNow */
#ifndef TOLUA_DISABLE_tolua_HXModules_HXMillisecondNow00
static int tolua_HXModules_HXMillisecondNow00(lua_State* tolua_S)
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
   long tolua_ret = (long)  HXMillisecondNow();
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'HXMillisecondNow'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* function: HXSaveScreenToRenderTexture */
#ifndef TOLUA_DISABLE_tolua_HXModules_HXSaveScreenToRenderTexture00
static int tolua_HXModules_HXSaveScreenToRenderTexture00(lua_State* tolua_S)
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
   CCRenderTexture* tolua_ret = (CCRenderTexture*)  HXSaveScreenToRenderTexture();
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"CCRenderTexture");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'HXSaveScreenToRenderTexture'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getInstance of class  HXEngine */
#ifndef TOLUA_DISABLE_tolua_HXModules_HXEngine_getInstance00
static int tolua_HXModules_HXEngine_getInstance00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"HXEngine",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   HXEngine* tolua_ret = (HXEngine*)  HXEngine::getInstance();
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"HXEngine");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getInstance'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: init of class  HXEngine */
#ifndef TOLUA_DISABLE_tolua_HXModules_HXEngine_init00
static int tolua_HXModules_HXEngine_init00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"HXEngine",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  HXEngine* self = (HXEngine*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'init'", NULL);
#endif
  {
   self->init();
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'init'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: exitGame of class  HXEngine */
#ifndef TOLUA_DISABLE_tolua_HXModules_HXEngine_exitGame00
static int tolua_HXModules_HXEngine_exitGame00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"HXEngine",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  HXEngine* self = (HXEngine*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'exitGame'", NULL);
#endif
  {
   self->exitGame();
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'exitGame'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: restartLuaEngine of class  HXEngine */
#ifndef TOLUA_DISABLE_tolua_HXModules_HXEngine_restartLuaEngine00
static int tolua_HXModules_HXEngine_restartLuaEngine00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"HXEngine",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  HXEngine* self = (HXEngine*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'restartLuaEngine'", NULL);
#endif
  {
   int tolua_ret = (int)  self->restartLuaEngine();
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'restartLuaEngine'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getScene of class  HXEngine */
#ifndef TOLUA_DISABLE_tolua_HXModules_HXEngine_getScene00
static int tolua_HXModules_HXEngine_getScene00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"const HXEngine",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  const HXEngine* self = (const HXEngine*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'getScene'", NULL);
#endif
  {
   CCScene* tolua_ret = (CCScene*)  self->getScene();
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"CCScene");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getScene'.",&tolua_err);
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
  tolua_function(tolua_S,"HXMillisecondNow",tolua_HXModules_HXMillisecondNow00);
  tolua_function(tolua_S,"HXSaveScreenToRenderTexture",tolua_HXModules_HXSaveScreenToRenderTexture00);
  tolua_cclass(tolua_S,"HXEngine","HXEngine","CCObject",NULL);
  tolua_beginmodule(tolua_S,"HXEngine");
   tolua_function(tolua_S,"getInstance",tolua_HXModules_HXEngine_getInstance00);
   tolua_function(tolua_S,"init",tolua_HXModules_HXEngine_init00);
   tolua_function(tolua_S,"exitGame",tolua_HXModules_HXEngine_exitGame00);
   tolua_function(tolua_S,"restartLuaEngine",tolua_HXModules_HXEngine_restartLuaEngine00);
   tolua_function(tolua_S,"getScene",tolua_HXModules_HXEngine_getScene00);
  tolua_endmodule(tolua_S);
 tolua_endmodule(tolua_S);
 return 1;
}


#if defined(LUA_VERSION_NUM) && LUA_VERSION_NUM >= 501
 TOLUA_API int luaopen_HXModules (lua_State* tolua_S) {
 return tolua_HXModules_open(tolua_S);
};
#endif

