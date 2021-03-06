#-------------------------------------------------
#
# Project created by QtCreator 2018-06-07T22:23:34
#
#-------------------------------------------------

QT       += widgets

TARGET = LinkDynamicLibTest6
TEMPLATE = lib

CONFIG += debug_and_release
CONFIG += build_all

# The following define makes your compiler emit warnings if you use
# any feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

#-------------------------------------------------
#Multi-link v2.4 提供的技术
#-------------------------------------------------
include($${PWD}/../../multi-link/add_base_manager.pri)

#本工程默认编译为动态库。
#此处更改工程编译状态，为用户提供自有状态CONFIG、宏，用户自主选择。
#add_dynamic_library_project()
add_static_library_project()
#mac:CONFIG -= lib_bundle

#-------------------------------------------------
#用户工程配置
#-------------------------------------------------
add_version(1,0,0,0)

#本库依赖QQt
add_dependent_manager(QQt)
add_custom_dependent_manager(AddDynamicLibTest2)

#本库导出SDK到LIB_SDK_ROOT
add_sdk($$add_target_name(), $$add_target_name())
#add_sdk_header_no_postfix(LinkDynamicLibTest, $$add_target_name(), LinkDynamicLibTest)

#-------------------------------------------------
#用户工程配置
#-------------------------------------------------
include($${PWD}/linkdynamiclibtest_header.pri)
include($${PWD}/linkdynamiclibtest_source.pri)

CONFIG += continue_build
contains(CONFIG, continue_build){
    system("touch $${PWD}/linkdynamiclibtest.cpp")
}

message($${TARGET} build obj dir $$add_host_path($${OUT_PWD}) $$OBJECTS_DIR)
message($${TARGET} build moc dir $$add_host_path($${OUT_PWD}) $$MOC_DIR)
message($${TARGET} build uih dir $$add_host_path($${OUT_PWD}) $$UI_DIR)
message($${TARGET} build rcc dir $$add_host_path($${OUT_PWD}) $$RCC_DIR)
message($${TARGET} build dst dir $$add_host_path($${OUT_PWD}) $$DESTDIR)
message ($${TARGET} QT $${QT})
message ($${TARGET} config $${CONFIG})
message ($${TARGET} DEFINE $${DEFINES})
