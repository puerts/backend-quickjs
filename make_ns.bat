::# From https://github.com/Tencent/puerts/issues/1796 Author:NiceTry12138 
set CUR_DIR=%~dp0
cd %CUR_DIR%

del /s/q buildnx64
mkdir buildnx64 & pushd buildnx64

set "NINTENDO_SDK_ROOT_CMAKE=%NINTENDO_SDK_ROOT:\=/%"
cmake -DCMAKE_C_COMPILER="%NINTENDO_SDK_ROOT_CMAKE%/Compilers/NX/nx/aarch64/bin/clang.exe" ^
	-DCMAKE_CXX_COMPILER="%NINTENDO_SDK_ROOT_CMAKE%/Compilers/NX/nx/aarch64/bin/clang++.exe" ^
	-G "Unix Makefiles" -DCMAKE_SYSTEM_NAME=Switch ^
        -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON ^
        -DSWITCH_PLATFORM=1 ^
        -DNS_US_ELF=1 ^
	-DCMAKE_C_FLAGS="-I%CUR_DIR%buildnx64" ^
	..
popd
cmake --build buildnx64 --config Release