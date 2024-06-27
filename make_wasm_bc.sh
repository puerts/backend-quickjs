if [ -n "$1" ]; then
    export QJSNS=1
else
    export QJSNS=0
fi


mkdir -p build_bc && cd build_bc
cmake -DQJS_NS=${QJSNS} -DBIYE_CODE=1 -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON ../
make
cd ..
mkdir -p ./qjs/quickjs/Lib/wasm/bc
find build_bc -type f -name "*.o" -exec bash -c 'cp "$0" "qjs/quickjs/Lib/wasm/bc/$(basename "$0" .o).bc"' {} \;
