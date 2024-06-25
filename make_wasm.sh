if [ -n "$1" ]; then
    export QJSNS=1
else
    export QJSNS=0
fi

git clone https://github.com/emscripten-core/emsdk.git
cd emsdk
git pull
./emsdk install 3.1.8
./emsdk activate 3.1.8
source ./emsdk_env.sh
cd ..

mkdir -p build_wasm && cd build_wasm
emcmake cmake -DQJS_NS=${QJSNS} -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON ../
cd ..
cmake --build build_wasm -DEMSCRIPTEN_GENERATE_BITCODE_STATIC_LIBRARIES=ON --config Release
mkdir -p ./qjs/quickjs/Lib/wasm/wasm32
cp build_wasm/libquickjs.bc ./qjs/quickjs/Lib/wasm/wasm32/