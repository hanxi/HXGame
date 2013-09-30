HXGame
======


## 目的：使用cocos2dx实现一个手机游戏的基本框架

* 使用cocos2dx 3.0 alpha

* HXModules文件夹自己主要需要完成的模块,包括手游中需要完成的通用代码都在此以模块的方式实现.
其中HXLuaModules.cpp是tolua++生成的文件.用于实现通用模块，比如在lua中重启lua脚本.

* libs文件夹拷贝自cocos2dx工程,减去了js相关的文件,里面的工程文件也做了相应的修改(现在完成了安卓工程和linux的编译和运行).


* proj文件夹拷贝自cocos2dx例子里的工程文件,修改了android工程和linux工程.在ubuntu13.04上完美编译运行.


* Resources文件夹用于存放资源和lua脚本.lua脚本目录格式也是有规则的.每个lua模块一个文件夹,并在include中包含他们.

* tools文件夹中的tolua++用来将cpp类或者c函数注册到lua中。
 

## 为何这样设计

* 这样修改cocos2dx的工程结构，并不是觉得cocos2dx的工程结构不好，只是只想把cocos2dx当做一个库来使用，而不是将cocos2dx作为主工程，
在cocos2dx中添加许许多多的工程。

* 也正是cocos2dx的工程做的相当完美，才有了其他人可以更好的配置工程结构。


## 框架设计来源
* 架构思想来自 <a target="_blank" href="http://guan-zhong-dao-ke.blog.163.com/blog/static/465446372012031114657379/">关中刀客</a>
* 框架结构图<br>
  ![image](https://github.com/hanxi/hanxi.github.com/raw/master/assets/media/2013-09-30-original-cocos2dx-game-frame.1.jpg)

------------------

[[涵曦个人博客]][[http://www.hanxi.info/]]

------------------
