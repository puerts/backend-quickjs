cmake_minimum_required(VERSION 3.10)

project(quickjs)

if (APPLE AND NOT IOS)
   set(CMAKE_OSX_DEPLOYMENT_TARGET "10.9" CACHE STRING "Minimum OS X deployment version")
   
   if ( NOT DEFINED FOR_SILICON )
       set(CMAKE_OSX_ARCHITECTURES x86_64)
   else ()
       set(CMAKE_OSX_ARCHITECTURES arm64)
   endif ()
endif()

# From https://github.com/Tencent/puerts/issues/1796 Author:NiceTry12138 
if (SWITCH_PLATFORM) 
    message("using v8_qjs SWITCH_PLATFORM >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")

    set(NINTENDO_SDK_ROOT $ENV{NINTENDO_SDK_ROOT})
    set(NS_INCLUDE "${NINTENDO_SDK_ROOT}/Include")
    set(NS_SPECIFIC_INCLUDE "${NINTENDO_SDK_ROOT}/TargetSpecificInclude/NX-Win32-v142")
    set(NS_AARCH64 "${NINTENDO_SDK_ROOT}/Compilers/NX/nx/aarch64")

    set(NS_INCLUDE_LIST ${NS_INCLUDE})                                                      # 定义搜索路径
    list(APPEND NS_INCLUDE_LIST ${NS_SPECIFIC_INCLUDE})                      # 添加特殊文件搜索路径
    list(APPEND NS_INCLUDE_LIST "${NS_AARCH64}/include")                    # 添加 AARCH64 头文件
    list(APPEND NS_INCLUDE_LIST "${NINTENDO_SDK_ROOT}/Include/nn/socket")   # 网络库相关
    
    set(NS_LIB_LIST "$${NS_AARCH64}/lib")                                                    # 添加 AARCH64 静态库
   
    if(NS_US_ELF)
        list(APPEND NS_INCLUDE_LIST "${NS_AARCH64}/include/aarch64-nintendo-nx-elf")
        list(APPEND NS_LIB_LIST "${NS_AARCH64}/lib/aarch64-nintendo-nx-elf")
    else ()
        list(APPEND NS_INCLUDE_LIST "${NS_AARCH64}/include/aarch64-nintendo-nx-nncfi")
        list(APPEND NS_LIB_LIST "${NS_AARCH64}/lib/aarch64-nintendo-nx-nncfi")
    endif()
    
    add_compile_options(-fdeclspec)
    add_definitions(-DNN_SDK_BUILD_RELEASE)
    add_definitions(-D__SWITCH__)
    
    include_directories(${NS_INCLUDE_LIST})
    link_directories(${NS_LIB_LIST})
endif()

if (PS_PLATFORM)
    message("using v8_qjs PS_PLATFORM >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")

    set(PS_SDK_ROOT $ENV{SCE_PROSPERO_SDK_DIR})
    set(PS_INCLUDE_LIST "${PS_SDK_ROOT}/target/include")
    list(APPEND PS_INCLUDE_LIST "${PS_SDK_ROOT}/target/include_common")

    set(PS_LIB_LIST "${PS_SDK_ROOT}/target/lib")
    add_definitions(-D__PS__)

    include_directories(${PS_INCLUDE_LIST})
    link_directories(${PS_LIB_LIST})

endif()

set(qjs_cflags -Wall)
if(CMAKE_C_COMPILER_ID MATCHES "AppleClang|Clang")
    list(APPEND qjs_cflags
            -Wextra
            -Wno-sign-compare
            -Wno-missing-field-initializers
            -Wno-unused-parameter
            -Wno-unused-variable
            -funsigned-char
            -fPIC)
else()
    list(APPEND qjs_cflags
            -Wno-array-bounds
            -Wno-unused-variable
            -Wno-unused-but-set-variable
            -fPIC)
endif()

set(SRC_FILES
        quickjs/cutils.c
        quickjs/dtoa.c
        quickjs/libregexp.c
        quickjs/libunicode.c
        quickjs/quickjs.c
        )
if ( NOT MSYS OR NOT WIN_DLL )
    list(APPEND SRC_FILES src/v8-impl.cc)
endif()

file(STRINGS "quickjs/_VERSION" QJS_VERSION_STR)

if (PS_PLATFORM)
    set (CMAKE_CXX_STANDARD 17)
else()
    set (CMAKE_CXX_STANDARD 20)
endif()

include_directories(
    include
    quickjs
)

if ( MSYS )
    if ( WIN_DLL )
        add_library(quickjs SHARED ${SRC_FILES})
    else ()
        add_library(quickjs STATIC ${SRC_FILES})
    endif()
    target_compile_definitions(quickjs PRIVATE
        _GNU_SOURCE
        CONFIG_BIGNUM
        CONFIG_VERSION="\\\"${QJS_VERSION_STR}\\\""
        )
else()
    if ( BUILD_SHARED )
        add_library(quickjs SHARED ${SRC_FILES})
    else ()
        add_library(quickjs STATIC ${SRC_FILES})
    endif()
    target_compile_definitions(quickjs PRIVATE
        _GNU_SOURCE
        CONFIG_BIGNUM
        CONFIG_VERSION="${QJS_VERSION_STR}"
    )
endif()

if (UNIX AND NOT OHOS AND NOT (CMAKE_SYSTEM_NAME MATCHES "Emscripten"))
    set(CMAKE_CXX_COMPILER "clang++")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -stdlib=libc++ -lc++abi")
endif ()

if (BIYE_CODE)
    set(CMAKE_C_COMPILER clang)
    set(CMAKE_CXX_COMPILER clang++)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -flto")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -flto")
endif ()

#set_target_properties(quickjs PROPERTIES
#        C_STANDARD 99
#        C_STANDARD_REQUIRED ON
#        )
target_compile_options(quickjs PRIVATE ${qjs_cflags})
if (CMAKE_BUILD_TYPE MATCHES Debug)
    target_compile_definitions(quickjs PRIVATE
            DUMP_LEAKS
            )
endif()

if (QJS_NS)
    message("using v8_qjs namespace >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
    target_compile_definitions(quickjs PRIVATE CUSTOMV8NAMESPACE=v8_qjs)
else  ()
    message("using v8 namespace >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
endif()

target_include_directories(quickjs PUBLIC ${CMAKE_SOURCE_DIR})
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    target_link_libraries(quickjs atomic)
endif()
