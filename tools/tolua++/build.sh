#!/bin/bash
#
# Invoked build.xml, overriding the lolua++ property

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
TOLUA="./tolua++.bin"
if [ -z "${TOLUA}" ]; then
    TOLUA=`which tolua++5.1`
fi

if [ -z "${TOLUA}" ]; then
    echo "Unable to find tolua++ (or tolua++5.1) in your PATH."
    exit 1
fi

cd ${SCRIPT_DIR}
#${TOLUA} -L basic.lua -o ../../libs/scripting/lua/cocos2dx_support/LuaCocos2d.cpp Cocos2d.pkg
${TOLUA} -L HXModules.lua -o ../../HXModules/HXLuaModules.cpp HXModules.pkg
echo OK...
