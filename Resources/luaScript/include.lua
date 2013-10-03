--[[=============================================================================
#     FileName: include.lua
#         Desc: 包含其他模块
#       Author: hanxi
#        Email: hanxi.com@gmail.com
#     HomePage: http://hanxi.cnblogs.com
#      Version: 0.0.1
#   LastChange: 2013-08-22 10:18:24
#      History:
=============================================================================]]

-- 添加包含模块
function include(module)
    local fileUtils  = CCFileUtils:getInstance()
    local mainPath   = fileUtils:fullPathForFilename("main.lua")
    scriptPath = string.sub(mainPath,1,#mainPath-9)
    local modulePath = scriptPath.."/"..module
    fileUtils:addSearchPath(modulePath)
    require(module)
end

include("util")
include("logic")

