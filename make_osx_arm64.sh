mkdir -p build && cd build
cmake -DFOR_SILICON=ON -GXcode ../
cd ..
cmake --build build --config Release
mkdir -p ./qjs/quickjs/Lib/macOS_arm64/
cp build/Release/libquickjs.a ./qjs/quickjs/Lib/macOS_arm64/