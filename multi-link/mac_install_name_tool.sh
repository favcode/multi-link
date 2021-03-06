#!/usr/bin/env bash
libpwd=$1
libname=$2
librealname=$3
app_bundle=$4
appname=$5
libmajorver=$(readlink ${libpwd}/${libname}.framework/Versions/Current)

find_path="@rpath"
if [ "${app_bundle}" = "no" ]; then
    find_path="@executable_path"
fi

#echo readlink ${libpwd}/${libname}.framework/Versions/Current
#echo
install_name_tool -change ${libname}.framework/Versions/${libmajorver}/${libname} ${find_path}/${libname}.framework/Versions/${libmajorver}/${librealname} ${appname}

