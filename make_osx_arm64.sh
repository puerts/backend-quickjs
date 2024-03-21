if [ -n "$1" ]; then
    export QJSNS=1
else
    export QJSNS=0
fi

mkdir -p build && cd build
cmake -DFOR_SILICON=ON -GXcode -DQJS_NS=${QJSNS} ../
cd ..
cmake --build build --config Release
mkdir -p ./qjs/quickjs/Lib/macOS_arm64/
cp build/Release/libquickjs.a ./qjs/quickjs/Lib/macOS_arm64/