##-----------------------------------------------------------------
##Multi-link配置工具入口
##-----------------------------------------------------------------
TEMPLATE = subdirs
CONFIG += ordered

SUBDIRS =

#直接编译运行即可配置多链接技术依赖的三个电脑路径。
SUBDIRS += demo/Multi-linkConfigTool

#然后，建立工程就可以在任何位置任意使用多链接技术。可以链接任何需要的Library。