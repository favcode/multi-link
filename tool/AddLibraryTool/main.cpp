﻿#include "mainwindow.h"
#include <QQtApplication>

#include <docopt.h>
#include <iostream>

static const char USAGE[] =
    R"(AddLibraryTool v1.0.

    Usage:
      AddLibraryTool
      AddLibraryTool output <root>
      AddLibraryTool (-h | --help)
      AddLibraryTool --version

    Options:
      -h --help     Show this screen.
      --version     Show version.
)";

int main ( int argc, char* argv[] )
{
    QQtApplication a ( argc, argv );

    MainWindow w;
    w.show();

    std::map<std::string, docopt::value> args = docopt::docopt(USAGE,
                                                  { argv + 1, argv + argc },
                                                  true,               // show help if requested
                                                  "AddLibraryTool v1.0");  // version string

    for(auto const& arg : args) {
        //std::cout << arg.first << ": " << arg.second << std::endl;
    }

    //std::cout << "HALLO" << std::endl;
    //std::cout << args["<root>"] << std::endl;
    if(bool(args["<root>"]) && args["<root>"] != docopt::value(""))
        w.setOutputPath(QString::fromStdString(args["<root>"].asString()));

    return a.exec();
}
