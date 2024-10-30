mkdir build & pushd build

if "%1" == "1" (
  cmake -DMD=ON -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DQJS_NS=1 -G "Visual Studio 17 2022" -A x64 ..
) else (
  cmake -DMD=ON -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -G "Visual Studio 17 2022" -A x64 ..
)
popd
cmake --build build --config Release
pause
