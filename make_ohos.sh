if [ -n "$1" ]; then
    export QJSNS=1
else
    export QJSNS=0
fi

if [ -n "$OHOS_NDK" ]; then
    export NDK=${OHOS_NDK}
elif [ -n "$OHOS_NDK_HOME" ]; then
    export NDK=${OHOS_NDK_HOME}
else
    export NDK=~/ohos-sdk/linux/native
fi

export PATH=${NDK}/build-tools/cmake/bin:$PATH

function build() {
    ABI=$1
    BUILD_PATH=build.OHOS.${ABI}
    cmake -H. -DOHOS_STL=c++_shared -B${BUILD_PATH} -DOHOS_ARCH=${ABI} -DOHOS_PLATFORM=OHOS -DCMAKE_TOOLCHAIN_FILE=${NDK}/build/cmake/ohos.toolchain.cmake -DQJS_NS=${QJSNS} -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
    cmake --build ${BUILD_PATH} --config Release
    mkdir -p ./qjs/quickjs/Lib/OHOS/${ABI}/
    cp ${BUILD_PATH}/libquickjs.a ./qjs/quickjs/Lib/OHOS/${ABI}/libquickjs.a
}

build armeabi-v7a
build arm64-v8a
