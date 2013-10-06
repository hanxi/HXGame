--[[=============================================================================
#     FileName: global.lua
#         Desc: 全局变量
#       Author: hanxi
#        Email: hanxi.com@gmail.com
#     HomePage: http://hanxi.cnblogs.com
#      Version: 0.0.1
#   LastChange: 2013-10-05 09:21:02
#      History:
=============================================================================]]
GVisibleSize = 0 -- 屏幕大小

-- 图标横纵个数
GBoardSizeX = confBoardSizeX
GBoardSizeY = confBoardSizeY

-- 映射到屏幕坐标后
-- 格子大小
GCellWidth =  0 -- = GVisibleSize.width*confCellWidth/confBackImgWidth
-- 图标开始摆放位置
GLeftBottomOffsetX = 0 -- GCellWidth/2
GLeftBottomOffsetY = 0 -- confLeftBottomOffsetImgY * GLeftBottomOffsetX / confLeftBottomOffsetImgX

-- 图标种类个数
GGameIconCount = 7
GBlinkIconIndex = 21

-- icon类型
GIconNormalType = 1
GIconCryType = 2
GIconMatchType = 3
GIconSelectType = 4

-- 分数
GTotalScore = 0

-- blink次数
GBlinkCount = 0

GBlinkCell = {x=7,y=9}

-- 剩余掉落icon个数
GLeftFallCount = 0

GLeftIconCell = {x=1,y=9}

