local SceneIdx  = -1
local MAX_LAYER = 42

local emitter = nil

local baseLayer_entry = nil

local function getBaseLayer()
    local layer = CCLayerColor:create(Color4B(127,127,127,255))

    emitter = nil

    local function onTouchEnded(x, y)
        local pos = CCPoint(0, 0)
        if emitter ~= nil then
            local newPos = CCPoint.__sub(CCPoint(x, y), pos)
            emitter:setPosition(newPos.x, newPos.y)
        end
    end

    local function onTouch(eventType, x, y)
        if eventType == "began" then
            return true
        else
            return onTouchEnded(x, y)
        end
    end

    layer:setTouchEnabled(true)
    layer:registerScriptTouchHandler(onTouch)

    return layer
end

function CreateParticleLayer()
    local layer = getBaseLayer()
    layer:setColor(Color3B(0, 20, 10))

    local parent = CCNode:create()
    emitter = CCParticleSystemQuad:create("Particles/BoilingFoam.plist")
    parent:addChild(emitter, 0, 1)
    layer:addChild(parent, 10, 10000)

    -- 添加一个CCLabelTTF    （！！！！！！备注！！！！！！）
    local myLableTTF = CCLabelTTF:create("涵曦", "helvetica-32", 24)
    local size = CCDirector:getInstance():getWinSize()
    myLableTTF:setPosition(CCPoint(size.width*0.5,size.height*0.5+100))
    layer:addChild(myLableTTF)

    return layer
end

function ParticleTest()
    cclog("ParticleTest")
    local scene = CCScene:create()
    scene:addChild(CreateParticleLayer())
    return scene
end
