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
require("global.lua")
require("include")

local function init()
    -- 添加资源路径
    local fileUtils  = CCFileUtils:getInstance()
    fileUtils:addSearchPath("audio")
    fileUtils:addSearchPath("fonts")
    fileUtils:addSearchPath("image")
    -- 初始化静态全局变量
    GVisibleSize = CCDirector:getInstance():getVisibleSize()
    GCellWidth = GVisibleSize.width*confCellWidth/confBackImgWidth
    GLeftBottomOffsetX = GCellWidth/2
    GLeftBottomOffsetY = confLeftBottomOffsetImgY * GLeftBottomOffsetX / confLeftBottomOffsetImgX
    -- 初始化游戏逻辑数据
    GameBoardInit()
end

local function main()
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    CCLuaLog("可写路径:"..CCFileUtils:getInstance():getWritablePath())
    init()
    CCDirector:getInstance():runWithScene(CreateMenuScene())
end

xpcall(main, __G__TRACKBACK__)

