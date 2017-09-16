cmake_minimum_required( VERSION 2.8.10 )

project( "restest" )

#
# Configuration
#
include( "${CMAKE_SOURCE_DIR}/cmake/configuration.cmake" )

#
# Dependencies
#
set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/modules" )

find_package( restbed REQUIRED )

include_directories( SYSTEM ${restbed_INCLUDE} )

#
# Build
#
include( "${CMAKE_SOURCE_DIR}/cmake/manifest.cmake" )

include_directories( ${INCLUDE_DIR} )

add_executable( ${PROJECT_NAME} ${MANIFEST} ${load_SOURCE} $<TARGET_OBJECTS:restbed> )
