::# From https://github.com/Tencent/puerts/issues/1796 Author:NiceTry12138 
set CUR_DIR=%~dp0
cd %CUR_DIR%

del /s/q buildPS5
mkdir buildPS5 & pushd buildPS5
cmake -G "Unix Makefiles" ^
    -DCMAKE_C_COMPILER="%SCE_PROSPERO_SDK_DIR%/host_tools/bin/prospero-clang.exe" ^
	-DCMAKE_CXX_COMPILER="%SCE_PROSPERO_SDK_DIR%/host_tools/bin/prospero-clang.exe" ^
    -DCMAKE_SYSTEM_NAME=Playstation ^
    -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON ^
    -DPS_PLATFORM=1 ^
    -DCMake_TOOLCHAIN_FILE="G:/PS/SCE/Prospero/Tools/CMake/PS5.cmake" ^
    ..

@REM set(CMAKE_TOOLCHAIN_FILE "G:/PS/SCE/Prospero/Tools/CMake/PS5.cmake")

popd
cmake --build buildPS5 --config Release

pause