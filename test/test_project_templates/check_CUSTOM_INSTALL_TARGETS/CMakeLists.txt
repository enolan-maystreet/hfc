set(FETCHCONTENT_QUIET OFF CACHE BOOL "" FORCE)
cmake_minimum_required(VERSION 3.27.6)
project(
  ModernCMakeExample
  VERSION 1.0
  LANGUAGES CXX)


set(CMAKE_MODULE_PATH
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake"
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules"
  ${CMAKE_MODULE_PATH}
)

include(HermeticFetchContent)

FetchContent_Declare(
  "mathlib"
  GIT_REPOSITORY "https://github.com/tipi-build/unit-test-cmake-template-2libs.git"
  GIT_TAG "c35bc46a3bc0f6ed7b14e11d34602079a3d8ab83"
)

FetchContent_MakeHermetic(
  "mathlib"
  BUILD_TARGETS "MathFunctions"
  CUSTOM_INSTALL_TARGETS "MathFunctions"
  HERMETIC_BUILD_SYSTEM cmake
  HERMETIC_CMAKE_EXPORT_LIBRARY_DECLARATION [=[
    add_library(MathFunctions::MathFunctions STATIC IMPORTED)
    set_property(TARGET MathFunctions::MathFunctions PROPERTY IMPORTED_LOCATION "@HFC_BINARY_DIR_PLACEHOLDER@/libMathFunctions.a")
    set_property(TARGET MathFunctions::MathFunctions PROPERTY INTERFACE_INCLUDE_DIRECTORIES @HFC_SOURCE_DIR_PLACEHOLDER@)
]=]
)

HermeticFetchContent_MakeAvailableAtBuildTime("mathlib")

add_executable(MyExample simple_example.cpp)
target_link_libraries(MyExample PRIVATE MathFunctions::MathFunctions)

