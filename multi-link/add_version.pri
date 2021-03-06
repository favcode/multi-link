#################################################################
#add_version.pri
#project version
#
#依赖 无
#
#please don't modify this pri
#################################################################

#Qt4 error parse. qmake v2
#embedded Qt5 error parse. qmake v3
defineReplace(get_version_string_one_piece) {
    major_version = $$1
    isEmpty(1):!isEmpty(2): error("get_version_string_one_piece(major) requires one arguments")
    command = $${major_version}
    return ($$command)
}
defineReplace(get_version_string_two_piece) {
    major_version = $$1
    minor_version = $$2
    isEmpty(2):!isEmpty(3): error("get_version_string_two_piece(major, minor) requires two arguments")
    command = $${major_version}.$${minor_version}
    return ($$command)
}
defineReplace(get_version_string_three_piece) {
    major_version = $$1
    minor_version = $$2
    patch_version = $$3
    isEmpty(3):!isEmpty(4): error("get_version_string_three_piece(major, minor, patch) requires three arguments")
    command = $${major_version}.$${minor_version}.$${patch_version}
    return ($$command)
}
defineReplace(get_version_string_four_piece) {
    major_version = $$1
    minor_version = $$2
    patch_version = $$3
    build_version = $$4
    isEmpty(4):!isEmpty(5): error("get_version_string_four_piece(major, minor, patch, build) requires four arguments")
    command = $${major_version}.$${minor_version}.$${patch_version}.$${build_version}
    return ($$command)
}

#-------------------------------------------------------------------------------
#User Make Version Function
#-------------------------------------------------------------------------------
PRE_VERSION =
PRE_LIB_VERSION =
PRE_APP_VERSION =
defineTest(add_version) {
    isEmpty(4):error(add_version(major, minor, patch, build) need four arguments.)

    APP_MAJOR_VERSION = $$1
    APP_MINOR_VERSION = $$2
    APP_PATCH_VERSION = $$3
    APP_BUILD_VERSION = $$4
    #message($$APP_MAJOR_VERSION $$APP_MINOR_VERSION $$APP_PATCH_VERSION $$APP_BUILD_VERSION)

    APP_VERSION1 = $$get_version_string_one_piece( $${APP_MAJOR_VERSION} )
    APP_VERSION2 = $$get_version_string_two_piece( $${APP_MAJOR_VERSION}, $${APP_MINOR_VERSION} )
    APP_VERSION3 = $$get_version_string_three_piece( $${APP_MAJOR_VERSION}, $${APP_MINOR_VERSION}, $${APP_PATCH_VERSION} )
    APP_VERSION4 = $$get_version_string_four_piece( $${APP_MAJOR_VERSION}, $${APP_MINOR_VERSION}, $${APP_PATCH_VERSION}, $${APP_BUILD_VERSION} )

    #这两个变量赋值是什么关系？
    #qmake 域变量
    APP_VERSION = $${APP_VERSION3}

    #清理上次的源代码 域宏
    DEFINES -= $$PRE_VERSION
    DEFINES -= $$PRE_LIB_VERSION
    DEFINES -= $$PRE_APP_VERSION
    PRE_VERSION = VERSION=$${APP_VERSION}
    PRE_LIB_VERSION = LIB_VERSION=$${APP_VERSION}
    PRE_APP_VERSION = APP_VERSION=$${APP_VERSION}
    export(PRE_VERSION)
    export(PRE_LIB_VERSION)
    export(PRE_APP_VERSION)

    #源代码 域宏    
    DEFINES += VERSION=$${APP_VERSION}
    contains(TEMPLATE, lib){
        DEFINES += LIB_VERSION=$${APP_VERSION}
    } else : contains(TEMPLATE, app) {
        DEFINES += APP_VERSION=$${APP_VERSION}
    }

    #用户版本宏
    !equals(APP_VERSION4, 0.0.0.0)|!isEmpty(TARGET_NAME) {
        APP_NAME = $$upper($${TARGET_NAME})
        DEFINES += $${APP_NAME}_VERSION=$${APP_VERSION}
    }

    #工程版本设置
    unix:VERSION = $${APP_VERSION}
    unix:VER_MAJ = $$APP_MAJOR_VERSION
    unix:VER_MIN = $$APP_MINOR_VERSION
    unix:VER_PAT = $$APP_PATCH_VERSION

    export(DEFINES)
    export(VERSION)
    export(VER_MAJ)
    export(VER_MIN)
    export(VER_PAT)
    export(APP_VERSION)
    export(APP_MAJOR_VERSION)
    export(APP_MINOR_VERSION)
    export(APP_PATCH_VERSION)
    export(APP_BUILD_VERSION)

    !equals(APP_VERSION4, 0.0.0.0):message ($${TARGET} version: v$$APP_VERSION4)
    return (1)
}

#-------------------------------------------------------------------------------
#User Make Version Inition
#调用一次进行初始化，用户后续进行的更改依然有效。
#-------------------------------------------------------------------------------
defineTest(add_default_version) {
    isEmpty(4):error(add_default_version(major, minor, patch, build) need four arguments.)

    APP_MAJOR_VERSION = $$1
    APP_MINOR_VERSION = $$2
    APP_PATCH_VERSION = $$3
    APP_BUILD_VERSION = $$4
    #message($$APP_MAJOR_VERSION $$APP_MINOR_VERSION $$APP_PATCH_VERSION $$APP_BUILD_VERSION)

    APP_VERSION1 = $$get_version_string_one_piece( $${APP_MAJOR_VERSION} )
    APP_VERSION2 = $$get_version_string_two_piece( $${APP_MAJOR_VERSION}, $${APP_MINOR_VERSION} )
    APP_VERSION3 = $$get_version_string_three_piece( $${APP_MAJOR_VERSION}, $${APP_MINOR_VERSION}, $${APP_PATCH_VERSION} )
    APP_VERSION4 = $$get_version_string_four_piece( $${APP_MAJOR_VERSION}, $${APP_MINOR_VERSION}, $${APP_PATCH_VERSION}, $${APP_BUILD_VERSION} )

    #这两个变量赋值是什么关系？
    #qmake 域变量
    APP_VERSION = $${APP_VERSION3}

    #清理上次的源代码 域宏
    DEFINES -= $$PRE_VERSION
    DEFINES -= $$PRE_LIB_VERSION
    DEFINES -= $$PRE_APP_VERSION
    PRE_VERSION = VERSION=$${APP_VERSION}
    PRE_LIB_VERSION = LIB_VERSION=$${APP_VERSION}
    PRE_APP_VERSION = APP_VERSION=$${APP_VERSION}
    export(PRE_VERSION)
    export(PRE_LIB_VERSION)
    export(PRE_APP_VERSION)

    #源代码 域宏
    DEFINES += VERSION=$${APP_VERSION}
    contains(TEMPLATE, lib){
        DEFINES += LIB_VERSION=$${APP_VERSION}
    } else : contains(TEMPLATE, app) {
        DEFINES += APP_VERSION=$${APP_VERSION}
    }

    #内部默认流程，关闭用户自有版本宏
    #用户版本宏
    #!equals(APP_VERSION4, 0.0.0.0)|!isEmpty(TARGET_NAME) {
    #    APP_NAME = $$upper($${TARGET_NAME})
    #    DEFINES += $${APP_NAME}_VERSION=$${APP_VERSION}
    #}

    #工程版本设置
    unix:VERSION = $${APP_VERSION}
    unix:VER_MAJ = $$APP_MAJOR_VERSION
    unix:VER_MIN = $$APP_MINOR_VERSION
    unix:VER_PAT = $$APP_PATCH_VERSION

    export(DEFINES)
    export(VERSION)
    export(VER_MAJ)
    export(VER_MIN)
    export(VER_PAT)
    export(APP_VERSION)
    export(APP_MAJOR_VERSION)
    export(APP_MINOR_VERSION)
    export(APP_PATCH_VERSION)
    export(APP_BUILD_VERSION)

    #内部默认流程，不打印
    #!equals(APP_VERSION4, 0.0.0.0):message ($${TARGET} version: v$$APP_VERSION4)
    return (1)
}

add_default_version(0, 0, 0, 0)
