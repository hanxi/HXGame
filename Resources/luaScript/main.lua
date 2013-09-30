--[[=============================================================================
#     FileName: main.lua
#         Desc: 启动函数文件
#       Author: hanxi
#        Email: hanxi.com@gmail.com
#     HomePage: http://hanxi.cnblogs.com
#      Version: 0.0.1
#   LastChange: 2013-08-22 10:02:17
#      History:
=============================================================================]]

require("conf.lua")
require("include")

require("ParticleTest")

local function init()
    -- 添加资源路径
    local fileUtils  = CCFileUtils:getInstance()
    fileUtils:addSearchPath("audio")
    fileUtils:addSearchPath("fonts")
    fileUtils:addSearchPath("image")
end

local function main()
    init()

    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    local sceneGame = ParticleTest()

    -- run
    CCDirector:getInstance():runWithScene(sceneGame)
    capi_restartLuaEngine()
    CCDirector:getInstance():runWithScene(sceneGame)
end

xpcall(main, __G__TRACKBACK__)

