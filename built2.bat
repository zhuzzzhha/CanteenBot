@echo off
set "boost_dir=C:\boost_1_80_0\"
set "boostlib_dir=C:\boost_1_80_0\lib\x64\lib\"
set "lib_path=%cd%\lib"
set "include_path=%lib_path%\include"
cmake -DBoost_INCLUDE_DIR=%boost_dir% -DBoost_LIBRARY_DIR_RELEASE=%boostlib_dir% -DCURL_INCLUDE_DIR=%include_path% -DOPENSSL_INCLUDE_DIR=%include_path% -G "Visual Studio 16 2019" -S . -B ./build 
cmake --build ./build
rem cmake --open ./build
