#----------------------------------------------------------------
#add_library_QQtExquisite.pri
#这是给用户提供的方便pri
#这个比较common，允许拷贝到用户工程中更改。
#----------------------------------------------------------------
#_bundle的取舍，在于macOS系统下，使用的library为bundle形式，还是dylib形式。

#######################################################################################
#初始化设置
#######################################################################################


#######################################################################################
#定义函数
#######################################################################################
#修改
defineTest(add_include_QQtExquisite){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    #isEmpty(1):header_path=$$get_add_include(QQtExquisite, QQtExquisite)

    command =
    #basic
    #command += $${header_path}
    #这里添加$${path}下的子文件夹
    #...
    #header_path = $$1
    header_path=$$get_add_include_bundle(QQtExquisite, QQtExquisite)
    command += $${header_path}
    command += $${header_path}/multipagewidget
    command += $${header_path}/multieventfilterwidget

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_QQtExquisite){
    #添加这个SDK里的defines
    #add_defines()

    #预估
    #QQtMessageQueue - libzmq
    #QQtDBus - QtDBus
    #QQtV4L2 Module - libv4l2

    export(QT)
    export(DEFINES)
    export(CONFIG)
    return (1)
}

#留意
defineTest(add_library_QQtExquisite){
    #这个地方add_library_bundle代表 macOS下，lib在bundle里。 留意
    #添加这个SDK里的library
    #add_library(QQtExquisite, QQtExquisite)
    add_library_bundle(QQtExquisite, QQtExquisite)

    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
#修改
defineTest(add_deploy_library_QQtExquisite) {
    #这个地方add_deploy_library_bundle代表macOS下发布的是bundle格式。
    #add_deploy_libraryes(QQtExquisite)
    #add_deploy_library(QQtExquisite, QQtExquisite)
    add_deploy_library_bundle(QQtExquisite, QQtExquisite)

    return (1)
}
