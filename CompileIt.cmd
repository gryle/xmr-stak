@echo off
PUSHD %~DP0
rem Execute next line only if compiling for Cuda 9.1 and using Visual Studio 2017 >= 15.5 (released 12/04/17)
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.11
echo ########## Running VsMSBuildCmd.bat
CALL "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\VsMSBuildCmd.bat"
echo ########## Setting CMAKE_PREFIX_PATH
set CMAKE_PREFIX_PATH=C:\xmr-stak-dep\hwloc;C:\xmr-stak-dep\libmicrohttpd;C:\xmr-stak-dep\openssl
echo ########## Making build directory
cd /D %~DP0
mkdir build
echo ########## Changing to build directory
cd build
echo ########## Running cmake -G "Visual Studio 15 2017 Win64" -T v141,host=x64 ..
rem cmake -G "Visual Studio 15 2017 Win64" -T v141,host=x64 -DCUDA_ENABLE=OFF ..
cmake -G "Visual Studio 15 2017 Win64" -T v141,host=x64 ..
echo ########## Running cmake --build . --config Release --target install
cmake --build . --config Release --target install
echo ########## Changing to bin\Release directory
cd bin\Release
echo ########## Copy OpenSLL DLLs
xcopy C:\xmr-stak-dep\openssl\bin\*.dll . /v
echo ########## Running Explorer
explorer.exe .
echo ########## Done... Exiting
POPD
