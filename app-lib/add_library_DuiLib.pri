#----------------------------------------------------------------
#add_library_DuiLib.pri
#这是给用户提供的方便pri
#这个比较common，允许拷贝到用户工程中更改。
#----------------------------------------------------------------
#_bundle的取舍，在于macOS系统下，使用的library为bundle形式，还是dylib形式。

#######################################################################################
#初始化设置
#######################################################################################
#1
LIBRARYVER =
#_bundle
BUNDLE =

#######################################################################################
#定义函数
#######################################################################################
#修改
defineTest(add_include_DuiLib){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    header_path=$$get_add_include_bundle(DuiLib, DuiLib)

    command =
    #basic
    command += $${header_path}
    #这里添加$${path}下的子文件夹
    #...

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_DuiLib){
    #添加这个SDK里的defines
    #add_defines()


    export(QT)
    export(DEFINES)
    export(CONFIG)
    return (1)
}

#留意
defineTest(add_static_defines_Duilib){
    #如果链接静态库，那么开启。编译也开启。
    DEFINES += DUILIB_STATIC_LIBRARY

    add_defines_DuiLib()

    export(DEFINES)
    return (1)
}

#修改
#这个地方add_library_bundle代表 macOS下，lib在bundle里。
defineTest(add_library_DuiLib){
    #添加这个SDK里的library
    add_library_bundle(DuiLib, DuiLib$${LIBRARYVER})

    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
#修改
defineTest(add_deploy_library_DuiLib) {
    add_deploy_library(DuiLib, DuiLib$${LIBRARYVER})
    #add_deploy_libraryes(DuiLib)
    return (1)
}
