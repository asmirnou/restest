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

find_package( asio REQUIRED )
find_package( json REQUIRED )
find_package( restbed REQUIRED )
find_package( kashmir REQUIRED )

include_directories( SYSTEM ${asio_INCLUDE} ${json_INCLUDE} ${restbed_INCLUDE} ${kashmir_INCLUDE} )

if ( BUILD_SSL )
    find_package( openssl REQUIRED )
    include_directories( SYSTEM ${ssl_INCLUDE} )
endif ( )

#
# Build
#
include( "${CMAKE_SOURCE_DIR}/cmake/manifest.cmake" )

include_directories( ${INCLUDE_DIR} )

add_executable( ${PROJECT_NAME} ${MANIFEST} ${load_SOURCE} $<TARGET_OBJECTS:restbed> )
