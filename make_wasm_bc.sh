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

mkdir -p build_wasm_bc && cd build_wasm_bc
emcmake cmake -DQJS_NS=${QJSNS} -DBIYE_CODE=1 -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON ../
emmake make
cd ..
mkdir -p ./qjs/quickjs/Lib/wasm/bc
ls build_wasm_bc/CMakeFiles/puerts.dir/Src/
cp build_wasm_bc/libquickjs.bc ./qjs/quickjs/Lib/wasm/bc/