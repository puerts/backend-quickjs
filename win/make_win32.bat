if "%1" == "1" (
  set QJSNS=1
) else (
  set QJSNS=0
)

mkdir build & pushd build
cmake -S ..\CMakeLists.win.txt -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DQJS_NS=${QJSNS} -G "Visual Studio 16 2019" -A Win32 ..
popd
cmake --build build --config Release
pause
