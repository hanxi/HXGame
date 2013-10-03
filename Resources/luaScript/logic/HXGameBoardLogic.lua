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

--require "Script/Config/CommonDefine"

--初始棋盘所有格子index均为0
GameBoard = {}
for i = 1, GBoardSizeX do
    GameBoard[i] = {}
    for j = 1, GBoardSizeY do
        GameBoard[i][j] = 0
    end
end

--获得某个节点的数据，越界返回 -1
local function getGameBoardData(x, y)
    local ret = -1
    if x > 0 and x < GBoardSizeX and y > 0 and y < GBoardSizeY then
        ret = GameBoard[x][y]
    end
    return ret
end

--随机生成初始棋盘，保证不含三连
function initGameBoard()
    for x = 1, GBoardSizeX do
        for y = 1, GBoardSizeY do
            repeat
                math.randomseed(math.random(os.time()))
                GameBoard[x][y] = math.random(GGameIconCount)
            until checkCell2({x = x, y = y}) == false
        end
    end
end

--触摸点转化为棋盘格子点
function touchPointToCell(x, y)
    local cellX = math.modf((x - GLeftBottomOffsetX) / GCellWidth)
    local cellY = math.modf((y - GLeftBottomOffsetY) / GCellWidth)
    local cell = {}
    cell.x = cellX + 1
    cell.y = cellY + 1

    if cell.x > GBoardSizeX or x < GLeftBottomOffsetX or cell.y > GBoardSizeY or y < GLeftBottomOffsetY then
        cell.x = 0
        cell.y = 0
    end

    return cell
end

--获取某个格子的中心坐标
function getCellCenterPoint(cell)
    local point = {}
    point.x = (cell.x - 1) * GCellWidth + GLeftBottomOffsetX + GCellWidth / 2
    point.y = (cell.y - 1) * GCellWidth + GLeftBottomOffsetY + GCellWidth / 2

    return point
end

--检查两个格子是否相邻
function isTwoCellNearby(cellA, cellB)
    local ret = false
    if (math.abs(cellA.x - cellB.x) == 1 and cellA.y == cellB.y) or
       (math.abs(cellA.y - cellB.y) == 1 and cellA.x == cellB.x) then
        ret = true
    end
    return ret
end

--检查某个格子是否组成3连,根据GameBoard数据
function checkCell(cell)
    local x = cell.x
    local y = cell.y

    local index = GameBoard[x][y]

    local ret = false

    local cond = {}
    cond[1] = x > 1 and GameBoard[x-1][y] == index
    cond[2] = x > 2 and GameBoard[x-2][y] == index
    cond[3] = x < GBoardSizeX and GameBoard[x+1][y] == index
    cond[4] = x < GBoardSizeX-1 and GameBoard[x+2][y] == index
    cond[5] = y > 1 and GameBoard[x][y-1] == index
    cond[6] = y > 2 and GameBoard[x][y-2] == index
    cond[7] = y < GBoardSizeY and GameBoard[x][y+1] == index
    cond[8] = y < GBoardSizeY-1 and GameBoard[x][y+2] == index

    if (cond[1] and cond[2]) or (cond[1] and cond[3]) or (cond[3] and cond[4]) or
        (cond[5] and cond[6]) or (cond[5] and cond[7]) or (cond[7] and cond[8]) then
        ret = true
    end

    return ret
end

function isOverSize(x,y)
    if x<1 or x>GBoardSizeX
        or y<1 or y>GBoardSizeY then
        return true
    end
    return false
end

-- 检查某个格子是否组成3连,算法2:可计算出消除元素
function checkCell2(cell)
    local x = cell.x
    local y = cell.y
    if isOverSize(x,y) then
        return false
    end
    local index = GameBoard[x][y]
    if not index then
        return false
    end
    --Horizontal）：水平方向排列；垂直（Vertical）
    local function lineSameCount(direction)
        local stopLeft = false
        local stopRight = false
        local sameCount = 1
        local i = 1
        local function stopFind(direction,flag)
            if direction=="horizontal" then
                local xx = x + i*flag
                if isOverSize(xx,y) then
                    return true
                else
                    if GameBoard[xx][y]==index then
                        sameCount = sameCount + 1
                        return false
                    end
                    return true
                end
            elseif direction=="vertial" then
                local yy = y + i*flag
                if isOverSize(x,yy) then
                    return true
                else
                    if GameBoard[x][yy]==index then
                        sameCount = sameCount + 1
                        return false
                    end
                    return true
                end
            end
        end

        local left=0
        local right=0
        while (true) do
            if not stopLeft then
                stopLeft = stopFind(direction,-1)
                if stopLeft then
                    left = i
                end
            end
            if not stopRight then
                stopRight = stopFind(direction,1)
                if stopRight then
                    right = i
                end
            end
            if stopLeft and stopRight then
                break
            end
            i = i+1
        end
        return sameCount,left,right
    end
    local horizontalSameCount,left,right = lineSameCount("horizontal")
    local vertialSameCount,up,down = lineSameCount("vertial")
    --CCLuaLog("hor:c="..horizontalSameCount..",x=["..tostring(x-left+1)..","..tostring(x+right-1).."]")
    --CCLuaLog("ver:c="..vertialSameCount..",y=["..tostring(y-up+1)..","..tostring(y+down-1).."]")
    -- 返回的结果,前两个是横纵的相同个数,left,right是横向相对于x的偏移,up,down时纵向相对于y的偏移
    local result = {
       horizontalSameCount=horizontalSameCount,
       vertialSameCount   =vertialSameCount,
       left               =left,
       right              =right,
       up                 =up,
       down               =down,}

    if horizontalSameCount<3 and vertialSameCount<3 then
        return false,result
    end
    return true,result
end

-- 获得可消除的格子集合
function getMatchCellSet(cell,res)
    local horizontalSameCount=res.horizontalSameCount
    local vertialSameCount   =res.vertialSameCount
    local left               =res.left
    local right              =res.right
    local up                 =res.up
    local down               =res.down
    local cellSet = {}
    if horizontalSameCount>=3 then
        for x=cell.x-left+1,cell.x+right-1 do
            local key = x..","..cell.y
            cellSet[key] = {x=x,y=cell.y}
        end
    end
    if vertialSameCount>=3 then
        for y=cell.y-up+1,cell.y+down-1 do
            local key = cell.x..","..y
            cellSet[key] = {x=cell.x,y=y}
        end
    end
    return cellSet
end

-- 获取可消除格子,根据blink
function getMatchCellSetWithBlink(cell,index)
    local cellSet = {}
    local key = cell.x..","..cell.y
    cellSet[key] = {x=cell.x,y=cell.y}
    for x=1,GBoardSizeX do
        for y=1,GBoardSizeY do
            if GameBoard[x][y]==index then
                key = x..","..y
                cellSet[key]={x=x,y=y}
            end
        end
    end
    return cellSet
end

--获得与某个格子同色相连的格子集合
function getNearbyCellSet(cell)
    local x = cell.x
    local y = cell.y
    local index = GameBoard[x][y]

    local cellSet = {}
    cellSet[#cellSet + 1] = {x = x, y = y}

    local assArray = {}
    local function addCellToSet(cell)
        if assArray[10 * cell.x + cell.y] == nil then
            cellSet[#cellSet + 1] = cell
            assArray[10 * cell.x + cell.y] = true
        end
    end

    local cond = {}
    cond[1] = x > 1 and GameBoard[x-1][y] == index
    cond[2] = x > 2 and GameBoard[x-2][y] == index
    cond[3] = x < GBoardSizeX and GameBoard[x+1][y] == index
    cond[4] = x < GBoardSizeX-1 and GameBoard[x+2][y] == index
    cond[5] = y > 1 and GameBoard[x][y-1] == index
    cond[6] = y > 2 and GameBoard[x][y-2] == index
    cond[7] = y < GBoardSizeY and GameBoard[x][y+1] == index
    cond[8] = y < GBoardSizeY-1 and GameBoard[x][y+2] == index

    if cond[1] and cond[2] then
        addCellToSet({x = x-1, y = y})
        addCellToSet({x = x-2, y = y})
    end

    if cond[1] and cond[3] then
        addCellToSet({x = x-1, y = y})
        addCellToSet({x = x+1, y = y})
    end

    if cond[3] and cond[4] then
        addCellToSet({x = x+1, y = y})
        addCellToSet({x = x+2, y = y})
    end

    if cond[5] and cond[6] then
        addCellToSet({x = x, y = y-1})
        addCellToSet({x = x, y = y-2})
    end

    if cond[5] and cond[7] then
        addCellToSet({x = x, y = y-1})
        addCellToSet({x = x, y = y+1})
    end

    if cond[7] and cond[8] then
        addCellToSet({x = x, y = y+1})
        addCellToSet({x = x, y = y+2})
    end

    return cellSet
end

--根据消除后的面板计算出棋子落下相关数据
function getRefreshBoardData()

    --记录每列中最下面的空格
    local firstEmptyCell = {}

    --记录每列所需要增加的数据
    local addCellList = {}

    --记录每列需要移动的棋子
    local moveCellList = {}

    for i = 1, GBoardSizeX do
        for j = 1, GBoardSizeY do
            if GameBoard[i][j] == 0 then
                if firstEmptyCell[i] == nil then
                    firstEmptyCell[i] = {x = i, y = j}
                end

                --随机生成index并加入对应列的addList
                math.randomseed(math.random(os.time()))
                local addIconIndex = math.random(GGameIconCount)

                if addCellList[i] == nil then
                    addCellList[i] = {}
                end
                addCellList[i][#(addCellList[i]) + 1] = addIconIndex
            else
                if moveCellList[i] == nil then
                    moveCellList[i] = {}
                end
                --判断是否已经检索到空节点
                if firstEmptyCell[i] ~= nil then
                    moveCellList[i][#(moveCellList[i]) + 1] = {x = i, y = j}
                end
            end
        end
    end

    return firstEmptyCell, addCellList, moveCellList
end

-- 填充棋盘
function getRandomIndex()
    math.randomseed(math.random(os.time()))
    local addIconIndex = math.random(GGameIconCount)
    return addIconIndex
end
-- 将新添加的格式移动到最上面
function moveNewCellToUp(cellSet)
    for x=1,GBoardSizeX do
        for y=1,GBoardSizeY do
            local key = x..","..y
            if cellSet[key] then
                local tmp = GameBoard[x][y]
                for k=y,GBoardSizeY-1 do
                    GameBoard[x][k] = GameBoard[x][k+1]
                end
                GameBoard[x][GBoardSizeY] = tmp
            end
        end
    end
end

--检测棋盘有无可移动消除棋子
function checkBoardMovable()
    local ret = false

    --检测交换两个节点数据后，棋盘是否可消除
    local function checkTwinCell(cellA, cellB)
        local ret = false

        GameBoard[cellA.x][cellA.y], GameBoard[cellB.x][cellB.y] = GameBoard[cellB.x][cellB.y], GameBoard[cellA.x][cellA.y]
        ret = checkCell2(cellA) or checkCell2(cellB)
        GameBoard[cellA.x][cellA.y], GameBoard[cellB.x][cellB.y] = GameBoard[cellB.x][cellB.y], GameBoard[cellA.x][cellA.y]

        return ret
    end

    local succList = {}

    --上下检测
    for i = 1, GBoardSizeX do
        for j = 1, GBoardSizeY - 1 do
            local cellA = {x = i, y = j}
            local cellB = {x = i, y = j + 1}
            if checkTwinCell(cellA, cellB) then
                succList[#succList + 1] = cellA
            end
        end
    end

    --左右检测
    for i = 1, GBoardSizeX - 1 do
        for j = 1, GBoardSizeY do
            local cellA = {x = i, y = j}
            local cellB = {x = i + 1, y = j}
            if checkTwinCell(cellA, cellB) then
                succList[#succList + 1] = cellA
            end
        end
    end

    if #succList > 0 then
        CCLuaLog("check success!!!")
        ret = true
    end

    return ret, succList
end
