cmake_minimum_required(VERSION 3.10)

set(ENV{FC} ifx)
set(CMAKE_FORTRAN_COMPILER ifx)

project( slatec
  VERSION 4.2
  DESCRIPTION "A comprehensive software library containing over 1400 general purpose mathematical and statistical routines written in Fortran."
  LANGUAGES Fortran
)

set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/modules/)
function(add_fortran_library LIB)
   add_library(${LIB} ${ARGN})
   # set module path to LIB_DIR/mod
   get_target_property(LIB_DIR ${LIB} BINARY_DIR)
   set_target_properties(${LIB} PROPERTIES Fortran_MODULE_DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY})
   # making LIB_DIR/mod available for libraries linking LIB
   target_include_directories(${LIB} INTERFACE ${CMAKE_Fortran_MODULE_DIRECTORY})
endfunction(add_fortran_library)

# SET BUILD OPTIONS
set(default_build_type "Release")
if (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to '${default_build_type}' as none was specified.")
  set(CMAKE_BUILD_TYPE "${default_build_type}" CACHE
      STRING "Choose the type of build." FORCE)
  # Set the possible values of build type for cmake-gui
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
    "Debug" "Release" "RelWithDebInfo")
endif()

set (CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})

set(CMAKE_Fortran_FLAGS_RELEASE        " -O3 -qmkl -diag-disable=10448") # -qopt-report
set(CMAKE_Fortran_FLAGS_DEBUG          " -qmkl -O0 -pg -traceback -init=snan -fpe0 -fpp -diag-enable=all \
                                         -warn all,noexternal  -diag-disable=5479 -qno-openmp-simd -no-simd \
                                         -fpmodel=precise -check all,nouninit -diag-disable=10448,13000")
set(CMAKE_Fortran_FLAGS_RELWITHDEBINFO " -O0 -qmkl -traceback -warn all")


add_subdirectory(src/service)
add_subdirectory(src/special_functions)
add_subdirectory(src/linear)
add_subdirectory(src/nonlin_eq)
add_subdirectory(src/optimization)
add_subdirectory(src/interpolation)
add_subdirectory(src/integ_trans)
add_subdirectory(src/data_handling)
add_subdirectory(src/diff_integ)
add_subdirectory(src/diff_integ_eq)
add_subdirectory(src/approximation)
add_subdirectory(src)
