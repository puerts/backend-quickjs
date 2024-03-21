if "%1" == "" (
  set QJSNS=0
) else (
  set QJSNS=1
)

mkdir build & pushd build
cmake -DMD=ON -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DQJS_NS=${QJSNS} -G "Visual Studio 16 2019" -A x64 ..
popd
cmake --build build --config Release
pause
