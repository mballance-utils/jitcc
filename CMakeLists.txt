
cmake_minimum_required(VERSION 3.14)

project(libtinycc)

include(ExternalProject)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STNDARD_REQUIRED True)

set(CMAKE_POSITION_INDEPENDENT_CODE True)

if (NOT PACKAGES_DIR)
    set(PACKAGES_DIR ${CMAKE_SOURCE_DIR}/packages)

    set(ENABLE_TESTING 1)

endif()

if (WIN32)
  set(PYTHON ${PACKAGES_DIR}/python/Scripts/python.exe)
else()
  set(PYTHON ${PACKAGES_DIR}/python/bin/python)
endif()

execute_process(COMMAND ${PYTHON} -m ivpm share cmake OUTPUT_VARIABLE IVPM_CMAKE_PATH)
list(APPEND CMAKE_MODULE_PATH ${IVPM_CMAKE_PATH})
message("IVPM_CMAKE_PATH: ${IVPM_CMAKE_PATH} ${CMAKE_MODULE_PATH}")

include(ivpm)

Ivpm_AddPythonExtProject(debug-mgr debug_mgr)

set (TINYCC_DIR "${PACKAGES_DIR}/tinycc")

ExternalProject_Add(TINYCC
    PREFIX tinycc
    SOURCE_DIR ${TINYCC_DIR}
  CMAKE_CACHE_ARGS
    CONFIGURE_COMMAND sh -c "${PACKAGES_DIR}/tinycc/configure --prefix=<INSTALL_DIR> --disable-static --debug"
    BUILD_COMMAND sh -c "make \\${MAKEFLAGS}"
    INSTALL_COMMAND sh -c "make \\${MAKEFLAGS} install"
    -DCMAKE_C_COMPILER:STRING=${CMAKE_C_COMPILER}
    -DCMAKE_CXX_COMPILER:STRING=${CMAKE_CXX_COMPILER}
    -DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS}
    -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
    -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
    -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_CURRENT_BINARY_DIR}
    -DCMAKE_OSX_ARCHTECTURES:STRING=${CMAKE_OSX_ARCHITECTURES}
  )

add_subdirectory(src)

install(FILES 
    ${CMAKE_BINARY_DIR}/tinycc/lib/libtcc.so
    DESTINATION lib)

install(DIRECTORY 
    ${CMAKE_BINARY_DIR}/tinycc/lib/tcc
    DESTINATION lib)

