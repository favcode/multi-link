#---------------------------------------------------------------------------------
#add_base_header.pri
#应用程序和Library的基础header。
#包含app工程、lib工程通用的宏(定义)、配置(定义)、依赖、[头文件]、编译参数、[平台]编译设置

#依赖 无
#please don't modify this pri
#---------------------------------------------------------------------------------
#################################################################
##definition and configration
##need QSYS
#################################################################
#in theory, this should not be limited to 4.8.0, no limit is good.
##Qt version
QT += core sql network gui xml
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

# release open debug output
CONFIG(debug, debug|release) {
} else {
    DEFINES -= QT_NO_DEBUG_OUTPUT
}

#compatible old version QQt (deperated)
#greaterThan(QT_MAJOR_VERSION, 4): DEFINES += __QT5__

#defined in qqtcore.h
#lessThan(QT_MAJOR_VERSION, 5):DEFINES += nullptr=0

#mingw要加速编译，make -j20，-j参数是最好的解决办法。

#CONFIG += debug_and_release
#CONFIG += build_all

#close win32 no using fopen_s warning
win32:DEFINES += _CRT_SECURE_NO_WARNINGS #fopen fopen_s

#msvc支持设置
msvc {
    MSVC_CCFLAGS =
    #this three pragma cause mingw errors
    msvc:MSVC_CCFLAGS += /wd"4819" /wd"4244" /wd"4100"

    #UTF8编码
    DEFINES += __MSVC_UTF8_SUPPORT__
    #开上边两个，
    #vs2015 32bit cl error D8016: /source..和/utf-8冲突；
    #开单独一个/utf-8，
    #vs2015 32bit cl error D8016: /utf-8和/execution...冲突；
    #最后，
    #仅仅开/source...
    #msvc:MSVC_CCFLAGS += /execution-charset:utf-8
    msvc:MSVC_CCFLAGS += /source-charset:utf-8
    #msvc:MSVC_CCFLAGS += /utf-8
    #/utf-8 这一个是快捷方式，顶上边两个。 这句话有误。
    #/exec... -> /utf-8 -> /source... 这是引发关系顺序
    #而vs2015 /utf-8始终和/source...冲突，这个关系和冲突说明/exec.... = /utf-8。弃。
    #解决方案：开/source...就够了。编译时。
    #微软在运行的时候还有一个编码环境，可以指定。但是这里无法指定，需要在命令行指定。微软自己搞的/exec /source竟然会冲突的。使用预编译功能的用户更换这个设置后需要rebuild。
    #LibQQt QQtApplication类，帮助用户进行运行时编码设定，设定为UTF-8。

    #指定/mp编译选项，编译器将使用并行编译，同时起多个编译进程并行编译不同的cpp
    #msvc:MSVC_CCFLAGS += /MP
    #指出：这个FLAG只能用于MSVC
    #这个功能可用，可是MSVC并行编译卡死IDE，不方便，所以默认不开开。
    #add_support.pri 里面对MSVC特有的诸多选项进行了支持，用户可以自主选择开启。

    msvc:QMAKE_CFLAGS += $${MSVC_CCFLAGS}
    msvc:QMAKE_CXXFLAGS += $${MSVC_CCFLAGS}

    #指定stable.h这个头文件作为编译预处理文件，MFC里这个文件一般叫stdafx.h 然后在 stable.h里 包含你所用到的所有 Qt 头文件
    #在.pro 文件中加入一行, 加在这里，加速编译。
    #msvc:PRECOMPILED_HEADER = $${PWD}/lib-qt.h
    #指出：precompiler header经常在MSVC中使用，gcc也可以使用。
    #这个功能可用，可是MSVC PCH编译问题比较多，不方便，所以默认不开开。
    #add_base_manager.pri 提供了add_pch()函数，用户可以自主选择预编译头文件。
}

#if some bug occured, maybe this help me, close some warning
CCFLAGS =
!win32:CCFLAGS = -Wno-unused-parameter -Wno-reorder -Wno-c++11-extensions -Wno-c++11-long-long -Wno-comment
QMAKE_CFLAGS +=  $${CCFLAGS}
QMAKE_CXXFLAGS +=  $${CCFLAGS}

#################################################################
##version
#################################################################
#user can use app_version.pri to modify app version once, once is all. DEFINES += APP_VERSION=0.0.0 is very good.
#unix:VERSION = $${QQT_VERSION}
#bug?:open this macro, TARGET will suffixed with major version.
#win32:VERSION = $${QQT_VERSION4}
QMAKE_TARGET_FILE = "$${TARGET}"
QMAKE_TARGET_PRODUCT = "$${TARGET}"
QMAKE_TARGET_COMPANY = "www.$${TARGET}.com"
QMAKE_TARGET_DESCRIPTION = "$${TARGET} Classes"
QMAKE_TARGET_COPYRIGHT = "Copyright (C) 2017-2022 $${TARGET} Co., Ltd. All rights reserved."

win32 {
    #common to use upload, this can be ignored.
    #open this can support cmake config.h.in
    #configure_file(qqtversion.h.in, qqtversion.h) control version via cmake.
    #qmake version config and cmake version config is conflicted
    #RC_FILE += qqt.rc
    #RC_ICONS=
    RC_LANG=0x0004
    RC_CODEPAGE=
}

#################################################################
##build lib or link lib
#################################################################
##different target:
##-----------------------------------------------
##win platform:
##build lib dll + LIB_LIBRARY
##build lib lib + LIB_STATIC_LIBRARY
##link lib lib + LIB_STATIC_LIBRARY
##link lib dll + ~~
##- - - - - - - - - - - - - - - - - - - - -
##*nix platform:
##build and link lib dll or lib + ~~
##-----------------------------------------------
#link Lib static library in some occation on windows
#when link Lib    static library, if no this macro, headers can't be linked on windows.
#在这里添加了LIB_STATIC_LIBRARY 用户可以使用 还有LIB_LIBRARY
#contains(QSYS_PRIVATE, Win32|Windows|Win64|MSVC32|MSVC|MSVC64|iOS|iOSSimulator)
#header里不再使用平台进行判定，而是使用工程当中定义的CONFIG static[lib] 和 dll进行判定。
#理论上mingw编译的Qt library不应该是静态的啊...
#Qt is static by mingw32 building?
#ios{
#    #on my computer, Qt library are all static library?
#    DEFINES += LIB_STATIC_LIBRARY
#    message(Build $${TARGET} LIB_STATIC_LIBRARY is defined. build and link)
#}
#
##link and build all need this macro
#contains(DEFINES, LIB_STATIC_LIBRARY) {
#}

##Multi-link对iOS的默认编译为静态，
##add_project.pri提供add_lib_project函数，
##add_base_manager.pri里调用这个函数，支持很完整，是真正的静态编译。
##但是，放在这里位置不合适，移动到add_lib_project()函数里，并在add_base_manager.pri里面调用。依然是静态编译。
##内部强制的默认动态编译步骤，和这个函数一样的意义，却会覆盖iOS的静态编译设置。所以在add_base_manager.pri，我关闭了强制动态，使用add_lib_project()。

##################C++11 Module###############################
#if you use C++11, open this annotation. suggest: ignore
#DEFINES += __CPP11__
contains (DEFINES, __CPP11__) {
    #macOS gcc Qt4.8.7
    #qobject.h fatal error: 'initializer_list' file not found,
    #Qt4.8.7 can't support c++11 features
    #QMAKE_CXXFLAGS += "-std=c++11"
    #QMAKE_CXXFLAGS += "-std=c++0x"

    #below: gcc version > 4.6.3
    #Open this Config, Why in Qt4 works? see qmake config auto ignored this feature.
    #In Qt5? don't need open this config, qmake auto add c++11 support on linux plat.
    #on windows mingw32? need test
    #CONFIG += c++11

    #compile period
    #LibLib need c++11 support. Please ensure your compiler version.
    #LibLib used override identifier
    #lambda also need c++11
}

#################################################################
##library
##################################################################
equals (QKIT_PRIVATE, iOSSimulator):{
    #error need
    #QMAKE_CXXFLAGS +=-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk
}

win32 {
    LIBS += -luser32
}else: unix {
    equals(QSYS_PRIVATE, macOS) {
        #min macosx target
        QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.9
        #deperated
        #QMAKE_MAC_SDK=macosx10.12
        #MACOSXSDK = /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX$${QMAKE_MACOSX_DEPLOYMENT_TARGET}.sdk
        #QMAKE_LIBDIR = $${MACOSXSDK}
        #LIBS += -F$${MACOSXSDK}/System/Library/Frameworks
        #LIBS += -L$${MACOSXSDK}/usr/lib
        LIBS += -framework DiskArbitration -framework Cocoa -framework IOKit
    }else:contains(QSYS_PRIVATE, iOS|iOSSimulator){
        QMAKE_LFLAGS += -ObjC -lsqlite3 -lz
        QMAKE_IOS_DEPLOYMENT_TARGET = 8
    }
}

################################################################
##build cache (此处为中间目标目录，对用户并不重要)
##此处加以干涉，使目录清晰。
##此处关于DESTDIR的设置，导致用户必须把这个文件的包含，提前到最前边的位置，才能进行App里的目录操作。
##删除干涉?
##用户注意：(done in app_base_manager), 首先include(app_link_lib_library.pri)，然后做app的工作，和include其他pri，包括LibLib提供的其他pri，保证这个顺序就不会出错了。
##对编译目标目录进行干涉管理，显得更加细腻。

##用户注意：这里相当于给编译中间目录加了一个自动校准，属于校正范畴。
##这样做保持了App工程和LibLib工程中间目录的一致性，但是并不必要。
##升级后的多链接技术，省略了BuildType目录，这个设置有必要了。
##默认，就分开了，无论Debug/Debug 还是Windows/Debug，就分开了。

##这里的设置已经不同于最初的目的了，开始的时候是为了目录的美观，进行分类划分，
##后来，BUILD目录有的同学不设置编译类型，这里进行强制Fix，分开编译，
##再后来，为了能够实现qmake build_all配置，这里强制Debug和Release分开，也就是无论IDE设置Debug模式还是Release模式，只要qmake build_all, Debug和Release都会被正确编译出来。
##现在的目的兼容过去的目的，目的变复杂了。
################################################################
defineTest(add_build_dir_struct){
    BUILD_DIR =
    !isEmpty(1):BUILD_DIR=$$1/

    OBJECTS_DIR =   $${BUILD_DIR}obj
    MOC_DIR =       $${BUILD_DIR}obj/moc.cpp
    UI_DIR =        $${BUILD_DIR}obj/ui.h
    RCC_DIR =       $${BUILD_DIR}obj/qrc.cpp
    DESTDIR =       $${BUILD_DIR}bin

    equals(QMAKE_HOST.os, Windows) {
        OBJECTS_DIR~=s,/,\\,g
        MOC_DIR~=s,/,\\,g
        UI_DIR~=s,/,\\,g
        RCC_DIR~=s,/,\\,g
        DESTDIR~=s,/,\\,g
    }

    export(OBJECTS_DIR)
    export(MOC_DIR)
    export(UI_DIR)
    export(RCC_DIR)
    export(DESTDIR)

    return (1)
}

#经过验证，在windows下debug和release中间目标的确不同。
#在macOS里，设置相同的编译目录，竟然一样，可是生成目标大小也一样...理论上应该不一样，可能是release覆盖了debug的中间目标。
#所以，这个地方，编译目录，无论如何debug和release要分开
add_build_dir_struct($${BUILD})

################################################################
##Lib Functions Macro
################################################################
#You need switch these more macro according to your needs when you build this library
#You can tailor Lib  with these macro.
#Default: macroes is configed, some open, some close, compatibled to special accotation.
##App希望裁剪LibLib，开关这个文件里的组件宏，用户有必要读懂这个头文件。up to so.
#应用于Library header.pri
