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

CCLuaLog = function(...)
    print(...)
end

--合并集合,根据key值
function HXUtilMergeSet(set1,set2)
    for k,v in pairs(set2) do
        set1[k] = v
    end
end

