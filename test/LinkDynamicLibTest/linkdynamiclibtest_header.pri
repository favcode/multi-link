##############################################################
#编译 LinkDynamicLibTest
#为用户编译本库提供头文件包含集、宏控制集方便。
##############################################################
#头文件
defineTest(add_include_LinkDynamicLibTest) {
    header_path=$${PWD}

    command =
    command += $${header_path}

    add_include_path($$command)
    return (1)
}

#本库使用的定义
defineTest(add_defines_LinkDynamicLibTest) {
    #--------------------------------------------
    #留意 LinkDynamicLibTest 使用的控制宏
    #--------------------------------------------

    #--------------------------------------------
    #Multi-link 提供 Template 的自有控制宏，
    #留意 Template 使用的控制宏
    #--------------------------------------------

    #--------------------------------------------
    #根据 LinkDynamicLibTest 使用的控制宏，修改 LinkDynamicLibTest 编译时、链接时的不同的宏配置。编译时，修改前两个判断分支；链接时，修改后两个判断分支。
    #可以用于转换使用不同宏、两套宏控制的链接库。
    #--------------------------------------------
    #LinkDynamicLibTest 动态编译时
    contains(DEFINES, LINKDYNAMICLIBTEST_LIBRARY){
        message(build LinkDynamicLibTest dynamic library)
    }
    #LinkDynamicLibTest 静态编译、链接时
    else:contains(DEFINES, LINKDYNAMICLIBTEST_STATIC_LIBRARY){
        message(build-link LinkDynamicLibTest static library)
    }
    #LinkDynamicLibTest 动态链接时
    else:!contains(DEFINES, LINKDYNAMICLIBTEST_LIBRARY){
        message(link LinkDynamicLibTest dynamic library)
    }

    #--------------------------------------------
    #添加库的宏配置信息，编译时、链接时通用，需要注意区分不同宏控制
    #建议先写动态编译、链接时的通用配置，然后增加对动态编译、链接，对静态编译、链接时的兼容处理。处理多个子模块时特别好用。
    #--------------------------------------------


    export(QT)
    export(DEFINES)
    export(CONFIG)
    return (1)
}

add_include_LinkDynamicLibTest()
add_defines_LinkDynamicLibTest()
