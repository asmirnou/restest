find_path(gtest_ROOT_DIR googletest HINTS "${CMAKE_SOURCE_DIR}/dependency/googletest")

if (gtest_ROOT_DIR)
    set(googletest_FOUND TRUE)
    message(STATUS "${Green}Found Google Test include at: ${gtest_ROOT_DIR}${Reset}")

    # Build googletest as part of our project directly
    file(MAKE_DIRECTORY ${gtest_ROOT_DIR}/build)
    execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" ..
            RESULT_VARIABLE result
            WORKING_DIRECTORY ${gtest_ROOT_DIR}/build)
    if (result)
        message(FATAL_ERROR "CMake step for googletest failed: ${result}")
    endif ()
    execute_process(COMMAND ${CMAKE_COMMAND} --build .
            RESULT_VARIABLE result
            WORKING_DIRECTORY ${gtest_ROOT_DIR}/build)
    if (result)
        message(FATAL_ERROR "Build step for googletest failed: ${result}")
    endif ()

    # Prevent overriding the parent project's compiler/linker
    # settings on Windows
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

    # Add googletest directly to our build. This defines
    # the gtest and gtest_main targets.
    add_subdirectory(${gtest_ROOT_DIR} ${gtest_ROOT_DIR}/build)

    # Include header search path dependencies
    include_directories("${gtest_SOURCE_DIR}/include")
else ()
    message(FATAL_ERROR "${Red}Failed to locate Google Test dependency.${Reset}")
endif ()
