if [ -n "$1" ]; then
    export QJSNS=1
else
    export QJSNS=0
fi

mkdir -p build_ios && cd build_ios
cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/ios.toolchain.cmake -DPLATFORM=OS64 -DQJS_NS=${QJSNS} -GXcode ../
cd ..
cmake --build build_ios --config Release
mkdir -p ./qjs/quickjs/Lib/iOS/arm64/
cp build_ios/Release-iphoneos/libquickjs.a ./qjs/quickjs/Lib/iOS/arm64/

