#----------------------------------------------------------------
#add_library_QScintilla.pri
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
defineTest(add_include_QScintilla){
    #不为空，肯定是源码里的路径。 用于导出头文件
    #header_path = $$1
    #如果参数1为空，那么是用SDK里的路径 用于链接时包含头文件
    #此处_bundle代表 mac下头文件在bundle里。 留意
    #isEmpty(1):header_path=$$get_add_include(QScintilla, QScintilla)

    command =
    #basic
    #command += $${header_path}
    #这里添加$${path}下的子文件夹
    #...
    header_path=$$get_add_include_bundle(QScintilla, qscintilla2)
    command += $${header_path}
    command += $${header_path}/designer-Qt4Qt5
    command += $${header_path}/doc
    command += $${header_path}/doc/html-Qt4Qt5
    command += $${header_path}/doc/Scintilla
    command += $${header_path}/example-Qt4Qt5
    command += $${header_path}/include
    command += $${header_path}/lexlib
    command += $${header_path}/Qt4Qt5
    command += $${header_path}/Qt4Qt5/Qsci
    command += $${header_path}/src

    INCLUDEPATH += $$command
    export(INCLUDEPATH)
    return (1)
}

#修改
defineTest(add_defines_QScintilla){
    #添加这个SDK里的defines
    #add_defines()
    #如果定义编译静态库，那么开启
    contains(DEFINES, LIB_STATIC_LIBRARY):DEFINES += QSCINTILLA_STATIC_LIBRARY

    return (1)
}

#修改
defineTest(add_library_QScintilla){
    #这个地方add_library_bundle代表 macOS下，lib在bundle里。 留意
    #添加这个SDK里的library
    #add_library(QScintilla, QScintilla)
    add_library_bundle(QScintilla, qscintilla2)

    return (1)
}


#发布依赖library
#注意Android也需要这个函数，使用这个函数Android才会发布Library到运行时。上边的只是链接作用。
#修改
defineTest(add_deploy_library_QScintilla) {
    #这个地方add_deploy_library_bundle代表macOS下发布的是bundle格式。
    #add_deploy_libraryes(QScintilla)
    #add_deploy_library(QScintilla, QScintilla)
    add_deploy_library_bundle(QScintilla, qscintilla2)

    return (1)
}