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
function getGameIconSprite(type, index)
    local iconFrame = CCSpriteFrameCache:getInstance():getSpriteFrameByName("icon"..type..index..".png")
    if iconFrame == nil then
        print("icon"..type..index..".png")
        print("iconFrame nil")
        return
    end
    local iconSprite = CCSprite:createWithSpriteFrame(iconFrame)
    return iconSprite
end

--创建随机变换的棋子
function createBlinkIconSprite()
    local iconSprite = getGameIconSprite(4, 1)
    local animation = CCAnimationCache:getInstance():animationByName("blinkAnimation")
    if animation==nil then
        local animFrames = CCArray:create()
        for i=1, GGameIconCount do
            local iconFrame = CCSpriteFrameCache:getInstance():getSpriteFrameByName("icon4"..i..".png")
            animFrames:addObject(iconFrame)
        end

        animation = CCAnimation:createWithSpriteFrames(animFrames, 0.1)
        CCAnimationCache:getInstance():addAnimation(animation,"blinkAnimation")
    end
    local animate = CCAnimate:create(animation);

    iconSprite:runAction(CCRepeatForever:create(animate))

    return iconSprite
end
