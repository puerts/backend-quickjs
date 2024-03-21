if [ -n "$1" ]; then
    export QJSNS=1
else
    export QJSNS=0
fi

mkdir -p build && cd build
cmake -DBUILD_SHARED=1 -GXcode -DQJS_NS=${QJSNS} ../
cd ..
cmake --build build --config Release
mkdir -p ./qjs/quickjs/Lib/macOSdylib/
cp build/Release/libquickjs.dylib ./qjs/quickjs/Lib/macOSdylib/
