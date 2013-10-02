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

local function init()
    -- 添加资源路径
    local fileUtils  = CCFileUtils:getInstance()
    fileUtils:addSearchPath("audio")
    fileUtils:addSearchPath("fonts")
    fileUtils:addSearchPath("image")
end

local function main()
    CCLuaLog("可写路径:"..CCFileUtils:getInstance():getWritablePath())

    init()

    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    local engine = HXEngine:getInstance()
    engine:init()

    local scene = engine:getScene()
    local layer = CCLayer:create()
    scene:addChild(layer)
    local sprite = CCSprite:create("100.png")
    layer:addChild(sprite)

    local function menuCallbackEnable(sender)
        CCLuaLog("hello menu")
        local render = HXSaveScreenToRenderTexture()
        render:saveToFile("screen.png",kCCImageFormatPNG);
        render:saveToFile("screen.jpg",kCCImageFormatJPEG);
        CCLuaLog("hello menu ok")
    end
    local startGameItem = CCMenuItemFont:create("Start");
    startGameItem:registerScriptTapHandler(menuCallbackEnable)
    local  menu = CCMenu:create()
    menu:addChild(startGameItem)

    layer:addChild(menu)

    local size = CCDirector:getInstance():getWinSize();
    local pos = CCPoint(size.width / 2, size.height / 2);
    sprite:setPosition(pos);
    sprite:setScale(5);

    --image:release();

    -- run
    CCDirector:getInstance():runWithScene(scene)
    --
    -- engine:restartLuaEngine()
end

xpcall(main, __G__TRACKBACK__)

