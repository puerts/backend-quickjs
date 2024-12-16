::# From https://github.com/Tencent/puerts/issues/1796 Author:NiceTry12138 
set CUR_DIR=%~dp0
cd %CUR_DIR%

del /s/q buildPS5
mkdir buildPS5 & pushd buildPS5

@REM SET(CMAKE_C_COMPILER   "${SCE_PROSPERO_SDK_DIR}/host_tools/bin/prospero-clang.exe"        CACHE PATH "C Compiler")
@REM SET(CMAKE_CXX_COMPILER "${SCE_PROSPERO_SDK_DIR}/host_tools/bin/prospero-clang.exe"        CACHE PATH "C++ Compiler")

@REM set(CMAKE_AS           "${SCE_PROSPERO_SDK_DIR}/host_tools/bin/prospero-clang.exe"        CACHE PATH "Assembler")
@REM set(CMAKE_AR           "${SCE_PROSPERO_SDK_DIR}/host_tools/bin/prospero-llvm-ar.exe"      CACHE PATH "Archive")
@REM set(CMAKE_LINKER       "${SCE_PROSPERO_SDK_DIR}/host_tools/bin/prospero-lld.exe"          CACHE PATH "Linker")
@REM set(CMAKE_NM           "${SCE_PROSPERO_SDK_DIR}/host_tools/bin/prospero-llvm-nm.exe"      CACHE PATH "NM")
@REM set(CMAKE_OBJCOPY      "${SCE_PROSPERO_SDK_DIR}/host_tools/bin/prospero-llvm-objcopy.exe" CACHE PATH "ObjCopy")
@REM set(CMAKE_OBJDUMP      "${SCE_PROSPERO_SDK_DIR}/host_tools/bin/prospero-llvm-objdump.exe" CACHE PATH "ObjDump")

cmake -DCMAKE_C_COMPILER="%SCE_PROSPERO_SDK_DIR%/host_tools/bin/prospero-clang.exe" ^
	-DCMAKE_CXX_COMPILER="%SCE_PROSPERO_SDK_DIR%/host_tools/bin/prospero-clang.exe" ^
	-DCMAKE_AS="%SCE_PROSPERO_SDK_DIR%/host_tools/bin/prospero-clang.exe" ^
	-DCMAKE_AR="%SCE_PROSPERO_SDK_DIR%/host_tools/bin/prospero-llvm-ar.exe" ^
	-DCMAKE_LINKER="%SCE_PROSPERO_SDK_DIR%/host_tools/bin/prospero-lld.exe" ^
	-DCMAKE_NM="%SCE_PROSPERO_SDK_DIR%/host_tools/bin/prospero-llvm-nm.exe" ^
	-DCMAKE_OBJCOPY="%SCE_PROSPERO_SDK_DIR%/host_tools/bin/prospero-llvm-objcopy.exe" ^
	-DCMAKE_OBJDUMP="%SCE_PROSPERO_SDK_DIR%/host_tools/bin/prospero-llvm-objdump.exe" ^
    -G "Unix Makefiles" ^
    -DCMAKE_SYSTEM_NAME=Playstation ^
    -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON ^
    -DPS_PLATFORM=1 ^
    ..
    
popd
cmake --build buildPS5 --config Release

pause