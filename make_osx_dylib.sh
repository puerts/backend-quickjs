mkdir -p build && cd build
cmake -DBUILD_SHARED=1 -GXcode ../
cd ..
cmake --build build --config Release
mkdir -p ./qjs/quickjs/Lib/macOSdylib/
cp build/Release/libquickjs.dylib ./qjs/quickjs/Lib/macOSdylib/
