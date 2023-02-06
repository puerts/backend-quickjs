copy /y ..\build\libquickjs.dll.a ..\build\libquickjs.dll.lib
mkdir build & pushd build
cmake -DMD=ON -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DCMAKE_SYSTEM_VERSION=10.0.19041.0 -DWIN_DLL=1 -G "Visual Studio 16 2019" -A x64 ..
popd
cmake --build build --config Release
pause
