-- usage: (use instead of ant)
-- tolua++ "-L" "HXModules.lua" "-o" "../../HXModules/HXLuaModules.cpp" "HXModules.pkg"

local toWrite = {}
local currentString = ''
local out
local WRITE, OUTPUT = write, output

function output(s)
    out = _OUTPUT
    output = OUTPUT -- restore
    output(s)
end

function write(a)
    if out == _OUTPUT then
        currentString = currentString .. a
        if string.sub(currentString,-1) == '\n'  then
            toWrite[#toWrite+1] = currentString
            currentString = ''
        end
    else
        WRITE(a)
    end
end

function post_output_hook(package)
    local result = table.concat(toWrite)
    local function replace(pattern, replacement)
        local k = 0
        local nxt, currentString = 1, ''
        repeat
            local s, e = string.find(result, pattern, nxt, true)
            if e then
                currentString = currentString .. string.sub(result, nxt, s-1) .. replacement
                nxt = e + 1
                k = k + 1
            end
        until not e
        result = currentString..string.sub(result, nxt)
        if k == 0 then print('Pattern not replaced', pattern) end
    end

    replace([[/* Exported function */
TOLUA_API int  tolua_HXModules_open (lua_State* tolua_S);

]],[[]])
    replace([[#ifndef __cplusplus
#include "stdlib.h"
#endif
#include "string.h"

#include "tolua++.h"]],
      [[/*=============================================================================
#     FileName: HXLuaModules.cpp
#         Desc: 导出HXModules到lua
#       Author: hanxi
#        Email: hanxi.com@gmail.com
#     HomePage: http://hanxi.cnblogs.com
#      Version: 0.0.1
=============================================================================*/
extern "C" {
#include "tolua_fix.h"
}

#include "HXModules.h"]])

    WRITE(result)
end
