
set(BUILD_RPATH_USE_ORIGIN 1)
set(CMAKE_INSTALL_RPATH $ORIGIN)

file (GLOB jitcc_SRC 
    "*.h" 
    "*.cpp")

add_library( jitcc SHARED ${jitcc_SRC})
add_dependencies(jitcc TINYCC)

target_include_directories(jitcc PUBLIC
    ${PROJECT_SOURCE_DIR}/src
    ${PROJECT_SOURCE_DIR}/src/include
    ${CMAKE_BINARY_DIR}/tinycc/include
    "${debug_mgr_INCDIR}"
)

target_link_directories(jitcc PUBLIC
    ${CMAKE_BINARY_DIR}/tinycc/lib
    ${CMAKE_BINARY_DIR}/lib
)

target_link_libraries(jitcc tcc)



install(TARGETS jitcc
    DESTINATION lib
    EXPORT jitcc-targets)
