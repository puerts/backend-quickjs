if [ -n "$1" ]; then
    export QJSNS=1
else
    export QJSNS=0
fi

git clone https://github.com/emscripten-core/emsdk.git
cd emsdk
git pull
./emsdk install latest
./emsdk activate latest
source ./emsdk_env.sh
cd ..

mkdir -p build_wasm && cd build_wasm
emcmake cmake -DQJS_NS=${QJSNS} -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON ../
emcmake cmake --build build_linux64 --config Release
cd ..
mkdir -p ./qjs/quickjs/Lib/wasm/
cp build_wasm/libquickjs.a ./qjs/quickjs/Lib/wasm/