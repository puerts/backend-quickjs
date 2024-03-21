if [ -n "$1" ]; then
    export QJSNS=1
else
    export QJSNS=0
fi

mkdir -p build_linux64 && cd build_linux64
cmake -DQJS_NS=${QJSNS} ../
cd ..
cmake --build build_linux64 --config Release
mkdir -p ./qjs/quickjs/Lib/Linux/
cp build_linux64/libquickjs.a ./qjs/quickjs/Lib/Linux/