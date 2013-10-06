--[[=============================================================================
#     FileName: HXGameIcon.lua
#         Desc: 读取游戏图片资源
#       Author: hanxi
#        Email: hanxi.com@gmail.com
#     HomePage: http://hanxi.cnblogs.com
#      Version: 0.0.1
#   LastChange: 2013-10-04 21:26:49
#      History:
=============================================================================]]
--[[
Copyright (c) 2013 crosslife <hustgeziyang@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]


--加载游戏图标资源
function loadGameIcon()
    CCSpriteFrameCache:getInstance():addSpriteFramesWithFile("GameIcon.plist")
end

--获取某个棋子
function getGameIconSprite(iconType, index)
    local iconFrame = CCSpriteFrameCache:getInstance():getSpriteFrameByName("icon"..iconType..index..".png")
    if iconFrame == nil then
        CCLuaLog("icon"..iconType..index..".png")
        CCLuaLog("iconFrame nil")
        return
    end
    local iconSprite = CCSprite:createWithSpriteFrame(iconFrame)

    local scalX = GCellWidth/confCellWidth
    local scalY = GCellWidth/confCellWidth
    iconSprite:setScaleX(scalX)
    iconSprite:setScaleY(scalY)
    return iconSprite
end

--创建随机变换的棋子
function createBlinkIconSprite(iconType)
    local iconSprite = getGameIconSprite(4, 1)
    local animation = CCAnimationCache:getInstance():animationByName("blinkAnimation"..iconType)
    if animation==nil then
        local animFrames = CCArray:create()
        for i=1, GGameIconCount do
            local iconFrame = CCSpriteFrameCache:getInstance():getSpriteFrameByName("icon"..iconType..i..".png")
            animFrames:addObject(iconFrame)
        end

        animation = CCAnimation:createWithSpriteFrames(animFrames, 0.1)
        CCAnimationCache:getInstance():addAnimation(animation,"blinkAnimation"..iconType)
    end
    local animate = CCAnimate:create(animation);
    iconSprite:runAction(CCRepeatForever:create(animate))

    return iconSprite
end

