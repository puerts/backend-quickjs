mkdir build & pushd build

if "%1" == "1" (
  cmake -S ..\CMakeLists.win.txt -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DQJS_NS=1 -G "Visual Studio 16 2019" -A Win32 ..
) else (
  cmake -S ..\CMakeLists.win.txt -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -G "Visual Studio 16 2019" -A Win32 ..
)
popd
cmake --build build --config Release
pause
