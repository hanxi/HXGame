--[[=============================================================================
#     FileName: HXUtil.lua
#         Desc: 工具函数
#       Author: hanxi
#        Email: hanxi.com@gmail.com
#     HomePage: http://hanxi.cnblogs.com
#      Version: 0.0.1
#   LastChange: 2013-08-22 10:08:40
#      History:
=============================================================================]]

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
end

function cclog(...)
    CCLuaLog(string.format(...))
end

