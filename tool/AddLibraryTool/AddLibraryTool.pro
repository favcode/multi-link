#-------------------------------------------------
#
# Project created by QtCreator 2018-06-14T08:33:19
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = AddLibraryTool
TEMPLATE = app

# The following define makes your compiler emit warnings if you use
# any feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0


SOURCES += \
        main.cpp \
        mainwindow.cpp

HEADERS += \
        mainwindow.h

FORMS += \
        mainwindow.ui

DEFINES += DOCOPT_HEADER_ONLY
INCLUDEPATH += docopt.cpp
#SOURCES += docopt.cpp/docopt.cpp
HEADERS += docopt.cpp/docopt.h
CONFIG += c++11

#这个工具会遍历SDK目录（选择一个SDK），把SDK生成为add_library_XXX.pri生成到app-lib下。
include(../../multi-link/add_base_manager.pri)
add_version(1,0,0,0)
add_deploy()
add_dependent_manager(QQt)
#add_dependent_manager(Template)

#是deploy环节依赖touch
system(touch main.cpp)
add_deploy_config($$PWD/AppRoot)

DISTFILES += AppRoot/add_library_Template.pri

