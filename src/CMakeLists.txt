
set(BUILD_RPATH_USE_ORIGIN True)

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

install(TARGETS jitcc
    DESTINATION lib
    EXPORT jitcc-targets)
