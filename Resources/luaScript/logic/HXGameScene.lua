--[[=============================================================================
#     FileName: HXGameScene.lua
#         Desc: 游戏场景及动画
#       Author: hanxi
#        Email: hanxi.com@gmail.com
#     HomePage: http://hanxi.cnblogs.com
#      Version: 0.0.1
#   LastChange: 2013-10-04 21:28:54
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

local scene = nil

local curSelectTag = nil

local NODE_TAG_START = 10000
local NORMAL_TAG = 10
local MATCH_TAG = 30
local SELECT_TAG = 40

local REMOVED_TAG = 20000

local isFallIngTbl = {}

local isTouching = false
local isRefreshing = false

local touchStartCell = {}

local switchCellSet = {}
local fallCellSet = {}

--用于存储执行交换结点
local switchCellPair = {}

-- 分数显示label
local ScoreLabel = nil

-- blink次数显示
local BlinkLabel = nil

--闪烁节点
local BlinkSprite = nil
local LeftIconSprite = nil

--根据index创建某类型结点，不包含额外信息
local function createNodeByIndex(index)
    local iconNormalSprite = getGameIconSprite(GIconNormalType, index)
    local iconMatchSprite = getGameIconSprite(GIconMatchType, index)
    local iconSelectSprite = getGameIconSprite(GIconSelectType, index)

    iconNormalSprite:setTag(NORMAL_TAG)
    iconMatchSprite:setTag(MATCH_TAG)
    iconSelectSprite:setTag(SELECT_TAG)

    iconMatchSprite:setVisible(false)
    iconSelectSprite:setVisible(false)

    local iconNode = CCNode:create()
    iconNode:addChild(iconNormalSprite)
    iconNode:addChild(iconMatchSprite)
    iconNode:addChild(iconSelectSprite)

    return iconNode
end

--创建某个位置上的结点图标
local function createNodeByCell(cell)
    local index = GameBoard[cell.x][cell.y]
    local iconNode = createNodeByIndex(index)

    iconNode:setTag(NODE_TAG_START + 10 * cell.x + cell.y)

    local cellPoint = getCellCenterPoint(cell)
    iconNode:setPosition(CCPoint(cellPoint.x, cellPoint.y))

    return iconNode
end

--初始化棋盘图标
local function initGameBoardIcon()
    for x=1, GBoardSizeX do
        for y = 1, GBoardSizeY do
            local iconNode = createNodeByCell({x = x, y = y})
            scene:addChild(iconNode)
        end
    end
end

--重置之前选中棋子的选中状态
local function resetSelectGameIcon()
    if curSelectTag ~= nil then
        local cellNode = scene:getChildByTag(NODE_TAG_START + curSelectTag)
        if cellNode ~= nil then
            local normalSprite = cellNode:getChildByTag(NORMAL_TAG)
            local selectSprite = cellNode:getChildByTag(SELECT_TAG)
            if normalSprite ~= nil then
                normalSprite:setVisible(true)
            end

            if selectSprite ~= nil then
                selectSprite:setVisible(false)
            end
        end
        curSelectTag = nil
    end
end

--点击棋子更换图标效果
local function onClickGameIcon(cell)
    if cell.x == 0 or cell.y == 0 then
        return
    end

    resetSelectGameIcon()

    curSelectTag = 10 * cell.x + cell.y

    scene:getChildByTag(NODE_TAG_START + curSelectTag):getChildByTag(NORMAL_TAG):setVisible(false)
    scene:getChildByTag(NODE_TAG_START + curSelectTag):getChildByTag(SELECT_TAG):setVisible(true)

    AudioEngine.playEffect("effect/A_select.wav")
end

--交换相邻棋子，并执行回调函数(一般为检测是否命中)
local function switchCell(cellA, cellB, cfCallBack)
    --CCLuaLog("switchCell...")
    --CCLuaLog("cellA.."..cellA.x.." "..cellA.y)
    --CCLuaLog("cellB.."..cellB.x.." "..cellB.y)
    isTouching = false

    resetSelectGameIcon()

    local tagA = 10 * cellA.x + cellA.y
    local tagB = 10 * cellB.x + cellB.y

    local cellPointA = getCellCenterPoint(cellA)
    local cellPointB = getCellCenterPoint(cellB)

    local nodeA = scene:getChildByTag(NODE_TAG_START + tagA)
    local nodeB = scene:getChildByTag(NODE_TAG_START + tagB)

    if nodeA == nil or nodeB == nil then
        CCLuaLog("can't find node!!")
        return
    end

    local moveToA = CCMoveTo:create(0.1, CCPoint(cellPointA.x, cellPointA.y))

    --将检测的回调函数绑定在A cell上
    local function moveAWithCallBack()

        local arrayOfActions = CCArray:create()

        local moveToB = CCMoveTo:create(0.1, CCPoint(cellPointB.x, cellPointB.y))
        arrayOfActions:addObject(moveToB)

        if cfCallBack ~= nil then
            --CCLuaLog("move with call back..")
            local callBack = CCCallFunc:create(cfCallBack)
            arrayOfActions:addObject(callBack)
        end

        local sequence = CCSequence:create(arrayOfActions)
        nodeA:runAction(sequence)
    end

    moveAWithCallBack()
    nodeB:runAction(moveToA)

    --swap tag
    nodeA:setTag(NODE_TAG_START + tagB)
    nodeB:setTag(NODE_TAG_START + tagA)

    --swap index
    GameBoard[cellA.x][cellA.y], GameBoard[cellB.x][cellB.y] = GameBoard[cellB.x][cellB.y], GameBoard[cellA.x][cellA.y]
end

--移除格子回调函数
local function cfRemoveSelf(matchSprite)
    --CCLuaLog("cf remove self")
    if matchSprite == nil then
        CCLuaLog("remove failed")
    else
        matchSprite:getParent():removeFromParentAndCleanup(true)
    end
end

--变为匹配图标并渐隐回调
local function cfMatchAndFade(node)
    if node ~= nil then
        local normalSprite = node:getChildByTag(NORMAL_TAG)
        local matchSprite = node:getChildByTag(MATCH_TAG)
        local selectSprite = node:getChildByTag(SELECT_TAG)
        if normalSprite ~= nil then
            normalSprite:setVisible(false)
        end

        if selectSprite ~= nil then
            selectSprite:setVisible(false)
        end

        if matchSprite ~= nil then
            matchSprite:setVisible(true)

            local arrayOfActions = CCArray:create()

            local fade = CCFadeOut:create(0.2)
            local removeFunc = CCCallFunc:create(cfRemoveSelf)

            arrayOfActions:addObject(fade)
            arrayOfActions:addObject(removeFunc)

            local sequence = CCSequence:create(arrayOfActions)

            matchSprite:runAction(sequence)
        end
    end
end

-- 刷新分数
local function updateScore()
    ScoreLabel:setString("Score : "..TotalScore)
end

-- 刷新次数
local function updateLeftIconCount()
    LeftIconLabel:setString(tostring(GLeftFallCount))
end

local function updateBlinkCount()
    BlinkLabel:setString(tostring(GBlinkCount))
end

--将某个集合的格子渐隐并移除
local function removeCellSet(cellSet)
    local toRemoveCell = {}
    local removeCellCount = 0
    for k,v in pairs(cellSet) do
        --此时直接清除数据
        --GameBoard[v.x][v.y] = 0

        local tag = 10 * v.x + v.y
        local node = scene:getChildByTag(NODE_TAG_START + tag)
        node:setTag(REMOVED_TAG + tag)
        node:runAction(CCCallFunc:create(cfMatchAndFade))
        removeCellCount = removeCellCount + 1
        if GLeftFallCount>=removeCellCount then
            toRemoveCell[k] = v
        end
    end
    local score = getScoreByCount(removeCellCount)
    TotalScore = TotalScore + score
    updateScore()

    -- 全部下落完毕
    local function cfFallDownEnd(node)
        local tag = node:getTag()-NODE_TAG_START
        local x = math.floor(tag/10)
        local y = tag%10
        --CCLuaLog("lastFallDown:",x,y)
        if GLeftFallCount<=0 then
            -- GameOver = true
            -- TODO
            return
        end
        table.remove(isFallIngTbl)
        checkFallCellSet()
    end

    table.insert(isFallIngTbl,1)
    fallCellSet = {}
    local step = {}
    for i=1,GBoardSizeX do
        step[i] = 0
        for j=1,GBoardSizeY do
            local tag = 10*i+j
            local node = scene:getChildByTag(NODE_TAG_START+tag)
            if step[i]>0 and node then
                local dstCell = {x=i,y=j-step[i]}
                local dstPoint = getCellCenterPoint(dstCell)
                local dstTag = 10*i+dstCell.y
                --CCLuaLog("from:",tag,"to:",dstTag)
                node:setTag(NODE_TAG_START+dstTag)
                GameBoard[dstCell.x][dstCell.y] = GameBoard[i][j]
                table.insert(fallCellSet,dstCell)
                local move = CCMoveTo:create(0.1, CCPoint(dstPoint.x,dstPoint.y))
                node:runAction(move)
            end
            local key = i..","..j
            if toRemoveCell[key] then
                step[i] = step[i] + 1
                GLeftFallCount = GLeftFallCount-1
            end
        end
    end
    for i=1,GBoardSizeX do
        if step[i]>0 then
            for j=1,step[i] do
                if removeCellCount > 0 then
                    local dstCell = {x=i,y=GBoardSizeY-j+1}
                    table.insert(fallCellSet,dstCell)
                    --CCLuaLog("dstCell:",i,dstCell.y)
                    GameBoard[dstCell.x][dstCell.y] = getRandomIndex()
                    --CCLuaLog("dstIndex:",GameBoard[dstCell.x][dstCell.y])
                    local node = createNodeByCell(dstCell)
                    local srcCell = GLeftIconCell
                    local srcPoint = getCellCenterPoint(srcCell)
                    node:setPosition(CCPoint(srcPoint.x,srcPoint.y))
                    --CCLuaLog("from:",i,GBoardSizeY)
                    scene:addChild(node)
                    local dstPoint = getCellCenterPoint(dstCell)
                    --CCLuaLog("to:",i,dstCell.y)
                    local move = CCMoveTo:create(0.1,CCPoint(dstPoint.x,dstPoint.y))
                    removeCellCount = removeCellCount - 1
                    updateLeftIconCount()
                    if removeCellCount==0 then
                        local arrayOfActions = CCArray:create()
                        arrayOfActions:addObject(move)
                        arrayOfActions:addObject(CCCallFunc:create(cfFallDownEnd))
                        local sequence = CCSequence:create(arrayOfActions)
                        node:runAction(sequence)
                    else
                        node:runAction(move)
                    end
                end
            end
        end
    end
end

--[[
--创建随机棋子下落到棋盘并改变棋盘数据
local function addBlinkIconToBoard()
    CCLuaLog("addBlinkIconToBoard")
    --随机落到棋盘某个点并改变该点数据
    local blinkCell = getRandomCell()

    --提前修改棋盘数据防止过程中交换
    GameBoard[blinkCell.x][blinkCell.y] = GBlinkIconIndex

    local tag = 10 * blinkCell.x + blinkCell.y
    local node = scene:getChildByTag(NODE_TAG_START + tag)
    --CCLuaLog("node :", node)
    node:removeFromParentAndCleanup(true)
    blinkSprite:setTag(NODE_TAG_START + tag)

    local blinkStartPoint = getCellCenterPoint({x = 6, y = 10})
    blinkSprite:setPosition(blinkStartPoint.x, blinkStartPoint.y)
    --CCLuaLog("addBlinkIconToBoard1")

    local fallEndPoint = getCellCenterPoint(blinkCell)

    local arrayOfActions = CCArray:create()

    local move = CCMoveTo:create(0.1, CCPoint(fallEndPoint.x , fallEndPoint.y))
    blinkSprite:runAction(move)
    --CCLuaLog("addBlinkIconToBoard:end")
    for i=1,GBoardSizeX do
        local str = ""
        for j=GBoardSizeY,1,-1 do
            local tag = 10*i+j
            local node = scene:getChildByTag(NODE_TAG_START + tag)
            if node then
                str = str .. tostring(node:getTag()).." "
            else
                str = str .."nilll "
            end
        end
        CCLuaLog(str)
    end
end
]]--

local function onCheckSuccess(succCellSet)
    if #succCellSet == 0 then
        return
    end

    --匹配成功
    CCLuaLog("switch success!!!")
    AudioEngine.playEffect("effect/A_combo1.wav")

    --to do: 执行消除，填充棋盘
    --获得邻近格子集合
    local matchCellSet = {}

    --用于检测是否已加入
    for k,v in pairs(succCellSet) do
        local matchCellSetTmp = getMatchCellSet(v.cell,v.result)
        HXUtilMergeSet(matchCellSet,matchCellSetTmp)
    end
    removeCellSet(matchCellSet)
end

-- 点击blink
function onClickBlinkCell()
    CCLuaLog("点击blink")
    if GBlinkCount<=0 then
        return
    end
    GBlinkCount = GBlinkCount - 1
    if GBlinkCount<=0 then
        --BlinkSprite:set -- 变成灰色不可点击
    end
    local animation = CCAnimationCache:getInstance():animationByName("blinkAnimation"..GIconSelectType)
    local curAnimIdx = 0
    local array = animation:getFrames()
    local n = array:count()-1
    CCLuaLog("n===",n)
    for i=0,n do
        local animFrame = tolua.cast(array:objectAtIndex(i),"CCAnimationFrame")
        local spriteFrame = animFrame:getSpriteFrame()
        CCLuaLog(i,animFrame,animFrame:getSpriteFrame())
        if BlinkSprite:isFrameDisplayed(animFrame:getSpriteFrame()) then
            curAnimIdx = i+1
            break
        end
    end
    local matchCellSet = getMatchCellSetWithBlink(curAnimIdx)
    removeCellSet(matchCellSet)
    AudioEngine.playEffect("effect/A_combo1.wav")
    CCLuaLog("消除全部=",curAnimIdx)
end

--检测落下的棋子是否命中
function checkFallCellSet()
--    CCLuaLog("cfCheckFallCell...")
    --复制为局部变量
    local checkSet = {}
    for k,v in pairs(fallCellSet) do
        table.insert(checkSet,v)
    end
    fallCellSet = {}

    --匹配成功的格子点
    local succCellSet = {}
    for k,v in pairs(checkSet) do
        local canRemove,result = checkCell(v)
        if canRemove then
            table.insert(succCellSet,{cell=v,result=result})
        end
    end

    if #succCellSet ~= 0 then
        onCheckSuccess(succCellSet)
    else
        local boardMovable, succList= checkBoardMovable()
        if #succList <= 333 then
            addBlink()
        end
    end
end

function addBlink()
    if GBlinkCount==0 then
        --BlinkSprite:set -- 设置成可点击状态
    end
    GBlinkCount = GBlinkCount + 1
    updateBlinkCount()
end

--检测互相交换的两个格子是否命中
function cfCheckSwitchCell()
    --CCLuaLog("cfCheckSwitchCell...")

    --复制为局部变量
    local checkSet = {}
    for i = 1, #switchCellSet do
        checkSet[#checkSet + 1] = switchCellSet[i]
    end

    --重置全局table
    switchCellSet = {}

    if #checkSet < 2 then
        return
    end

    --匹配成功的格子点
    local succCellSet = {}
    for i = 1, #checkSet do
        local canRemove,result = checkCell(checkSet[i])
        if canRemove then
            succCellSet[#succCellSet + 1] = {cell=checkSet[i],result=result}
        end
    end

    if #succCellSet == 0 then
        --匹配失败
        CCLuaLog("switch failed...")

        --还原移动并清空交换区
        switchCell(switchCellPair[1], switchCellPair[2], nil)
        switchCellPair = {}

        AudioEngine.playEffect("effect/A_falsemove.wav")
    else
        onCheckSuccess(succCellSet)
    end
end

--背景层
local function createBackLayer()
    local backLayer = CCLayer:create()

    local backSprite = CCSprite:create("game_bg.png")
    local scalX = GVisibleSize.width/backSprite:getContentSize().width
    local scalY = GVisibleSize.height/backSprite:getContentSize().height
    backSprite:setScaleX(scalX)
    backSprite:setScaleY(scalY)
    backSprite:setPosition(GVisibleSize.width / 2, GVisibleSize.height / 2)

    backLayer:addChild(backSprite)

    for k=0,60 do
        local i = k%(GBoardSizeX+2)
        local j = math.floor(k/(GBoardSizeX+2))+1
        --CCLuaLog(i,j)
        local color = Color4B(28,31,42,255)
        if k%2==0 then
            color = Color4B(37,40,51,255)
        end
        local color_layer = CCLayerColor:create(color)
        local c_size = CCSize(GCellWidth,GCellWidth)
        color_layer:setContentSize(c_size)
        local p = getCellLeftDownPoint({x=i,y=j})
        color_layer:setPosition(CCPoint(p.x,p.y))
        backLayer:addChild(color_layer)
    end

    return backLayer
end

--触摸层
local function createTouchLayer()

    local touchColor = Color4B:new(255, 255, 255 ,0)
    local touchLayer = CCLayerColor:create(touchColor)

    touchLayer:changeWidthAndHeight(GVisibleSize.width, GVisibleSize.height)

    local function onTouchBegan(x, y)
        local touchCell = touchPointToCellNoCechk(x, y)
        if touchCell.x==GBlinkCell.x and touchCell.y==GBlinkCell.y then
            -- 清除blink相同的
            onClickBlinkCell()
            return
        end
        --CCLuaLog("touchLayerBegan:",GVisibleSize.width, GVisibleSize.height, x, y)
        isTouching = true
        touchStartCell = touchPointToCell(x, y)
        --touchStartPoint = {x = x, y = y}
        if curSelectTag ~= nil then
            local curSelectCell = {x = math.modf(curSelectTag / 10), y = curSelectTag % 10}
            if isTwoCellNearby(curSelectCell, touchStartCell) then
                switchCellSet = {}
                switchCellSet[#switchCellSet + 1] = curSelectCell
                switchCellSet[#switchCellSet + 1] = touchStartCell

                switchCellPair[1] = curSelectCell
                switchCellPair[2] = touchStartCell
                switchCell(curSelectCell, touchStartCell, cfCheckSwitchCell)

                return true
            end
        end
        onClickGameIcon(touchStartCell)

        return true
    end

    local function onTouchMoved(x, y)
        --CCLuaLog("touchLayerMoved: %.2f, %.2f", x, y)
        local touchCurCell = touchPointToCell(x, y)
        if  isTouching then
            if isTwoCellNearby(touchCurCell, touchStartCell) then
                switchCellSet = {}
                switchCellSet[#switchCellSet + 1] = touchCurCell
                switchCellSet[#switchCellSet + 1] = touchStartCell

                switchCellPair[1] = touchCurCell
                switchCellPair[2] = touchStartCell
                switchCell(touchCurCell, touchStartCell, cfCheckSwitchCell)
            end
        end
    end

    local function onTouchEnded(x, y)
        --CCLuaLog("touchLayerEnded: %.2f, %.2f", x, y)
        --touchEndPoint = {x = x, y = y}
        --touchEndCell = touchPointToCell(x, y)
        isTouching = false
    end


    local function onTouch(eventType, x, y)
        if #isFallIngTbl>0 then
            return
        end
        if eventType == "began" then
            return onTouchBegan(x, y)
        elseif eventType == "moved" then
            return onTouchMoved(x, y)
        elseif eventType == "ended" then
            return onTouchEnded(x, y)
        end
    end

    touchLayer:registerScriptTouchHandler(onTouch)
    touchLayer:setTouchEnabled(true)

    return touchLayer
end


-- create game scene
function CreateGameScene()

    scene = CCScene:create()
    scene:addChild(createBackLayer())

    AudioEngine.stopMusic(true)

    local bgMusicPath = CCFileUtils:getInstance():fullPathForFilename("music/bgm_game.wav")
    AudioEngine.playMusic(bgMusicPath, true)

    loadGameIcon()

    initGameBoard()
    initGameBoardIcon()

    scene:addChild(createTouchLayer(), 1000)

    -- 分数显示
    ScoreLabel = CCLabelTTF:create("Score : 0", "Marker Felt", 50)
    scene:addChild(ScoreLabel)
    ScoreLabel:setPosition(GVisibleSize.width/2,GVisibleSize.height*0.9)
    TotalScore = 0

    -- blink次数显示
    BlinkLabel = CCLabelTTF:create(tostring(GBlinkCount),"Marker Felt",30)
    scene:addChild(BlinkLabel)
    local pos = getCellCenterPoint({x=GBlinkCell.x-1,y=GBlinkCell.y})
    BlinkLabel:setPosition(pos.x,pos.y)

    --在棋盘上显示该随机棋子:消除点击瞬间那一帧图像相同的棋子
    BlinkSprite = createBlinkIconSprite(GIconSelectType)
    local pos = getCellCenterPoint(GBlinkCell)
    BlinkSprite:setPosition(pos.x,pos.y)
    scene:addChild(BlinkSprite)

    -- left剩余icon个数显示
    GLeftFallCount = 60
    LeftIconLabel = CCLabelTTF:create(tostring(GLeftFallCount),"Marker Felt",30)
    scene:addChild(LeftIconLabel)
    local pos = getCellCenterPoint({x=GLeftIconCell.x+1,y=GLeftIconCell.y})
    LeftIconLabel:setPosition(pos.x,pos.y)

    LeftIconSprite = createBlinkIconSprite(GIconNormalType)
    local pos = getCellCenterPoint(GLeftIconCell)
    LeftIconSprite:setPosition(pos.x,pos.y)
    scene:addChild(LeftIconSprite)

    return scene
end
