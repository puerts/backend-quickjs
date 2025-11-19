cmake_minimum_required(VERSION 3.10)

option ( MD "MD" OFF )

if ( WIN32 AND NOT CYGWIN AND NOT ( CMAKE_SYSTEM_NAME STREQUAL "WindowsStore" ) AND NOT ANDROID)
    if (MD)
        set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} /MD" CACHE STRING "")
        set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} /MDd" CACHE STRING "")
        set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MD" CACHE STRING "")
        set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MDd" CACHE STRING "")
    else ()
        set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} /MT" CACHE STRING "")
        set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} /MTd" CACHE STRING "")
        set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MT" CACHE STRING "")
        set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MTd" CACHE STRING "")
    endif ()
endif ()

project(v8qjs)

if (APPLE AND NOT IOS)
   set(CMAKE_OSX_DEPLOYMENT_TARGET "10.9" CACHE STRING "Minimum OS X deployment version")
endif()

set(qjs_cflags -Wall)

set(CMAKE_C_STANDARD 99)
set (CMAKE_CXX_STANDARD 20)

include_directories(
    ../include
    ../quickjs
)

if (NOT WIN_DLL )

add_library(v8qjs STATIC
        ../src/v8-impl.cc
        )

else ()

add_library(v8qjs SHARED
        ../src/v8-impl.cc
        )

target_link_libraries(v8qjs
            ../../build/libquickjs.dll
        )

#set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
target_compile_definitions (v8qjs PRIVATE BUILDING_V8_SHARED BUILDING_V8_PLATFORM_SHARED)

endif ()

if (QJS_NS)
    message("using v8_qjs namespace >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
    target_compile_definitions(v8qjs PRIVATE CUSTOMV8NAMESPACE=v8_qjs)
else  ()
    message("using v8 namespace >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
endif()
#target_compile_definitions(v8qjs PRIVATE CUSTOMV8NAMESPACE=v8_qjs)

target_compile_options(v8qjs PRIVATE ${qjs_cflags})
target_compile_definitions(v8qjs PRIVATE
        _GNU_SOURCE
        CONFIG_BIGNUM
        )



