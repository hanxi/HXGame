--[[=============================================================================
#     FileName: conf.lua
#         Desc: 配置文件
#       Author: hanxi
#        Email: hanxi.com@gmail.com
#     HomePage: http://hanxi.cnblogs.com
#      Version: 0.0.1
#   LastChange: 2013-08-23 10:23:44
#      History:
=============================================================================]]

-- 全局变量
GBackGroundWidth = 712
GBackGroundHeight = 1024

GLeftBottomOffsetX = 42
GLeftBottomOffsetY = 100

GCellWidth = 90

GBoardSizeX = 7
GBoardSizeY = 7

GGameIconCount = 7
GBlinkIconIndex = 21

GBackGroundMiddlePoint = {x = 356, y = 512}

GIconNormalType = 1
GIconCryType = 2
GIconMatchType = 3
GIconSelectType = 4

-- 分数
TotalScore = 0
scoreConf = {}
for i=3,7 do
    scoreConf[i] = 2^(i-2)
end


