mkdir -p build_linux64 && cd build_linux64
cmake ../
cd ..
cmake --build build_linux64 --config Release
mkdir -p ./qjs/quickjs/Lib/Linux/
cp build_linux64/libquickjs.a ./qjs/quickjs/Lib/Linux/