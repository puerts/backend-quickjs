if [ -n "$1" ]; then
    export QJSNS=1
else
    export QJSNS=0
fi

mkdir -p build && cd build
cmake -GXcode -DQJS_NS=${QJSNS} ../
cd ..
cmake --build build --config Release
mkdir -p ./qjs/quickjs/Lib/macOS/
cp build/Release/libquickjs.a ./qjs/quickjs/Lib/macOS/