cmake_minimum_required(VERSION 3.14)
##########################################################
project(course_test)			

set(VCPKG_ROOT_DIR "C:/vcpkg")
set(CMAKE_TOOLCHAIN_FILE ${VCPKG_ROOT_DIR}/scripts/buildsystems/vcpkg.cmake)
set(TGBot_INCLUDE_DIR ${VCPKG_ROOT_DIR}/installed/x64-windows/include)
set(TGBot_LIB ${VCPKG_ROOT_DIR}/installed/x64-windows/lib/TgBot.lib)
set(TGBot_ROOT_DIR ${VCPKG_ROOT_DIR}/installed/x64-windows/lib)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
set(Boost_USE_MULTITHREADED ON)

##########################################################
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_BINARY_DIR}/install" CACHE PATH "..." FORCE)
endif()

find_package(Threads REQUIRED)
find_package(OpenSSL REQUIRED)
find_package(Boost COMPONENTS system REQUIRED)
find_package(CURL)
find_package(SQLite3)

if(NOT SQLite3_FOUND)
	message(SEND_ERROR "Failed to find SQLite3.")
	return()
else()
	message(STATUS "SQLite3 library: ${SQLite3_LIBRARIES}") 
	include_directories(${SQLite3_INCLUDE_DIRS})
endif()


include_directories(${TGBot_INCLUDE_DIR} ${OPENSSL_INCLUDE_DIR} ${Boost_INCLUDE_DIR} ${SQLite3_INCLUDE_DIR})
if (CURL_FOUND)
    include_directories(${CURL_INCLUDE_DIRS})
    add_definitions(-DHAVE_CURL)
endif()

##########################################################
add_executable(course_test TgBot/src/source.cpp)
##########################################################
 
target_link_libraries(course_test PUBLIC ${TGBot_LIB} ${CMAKE_THREAD_LIBS_INIT} ${OPENSSL_LIBRARIES} ${Boost_LIBRARIES} ${CURL_LIBRARIES} ${SQLite3_LIBRARIES})

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})

install(TARGETS course_test DESTINATION .)
#install(IMPORTED_RUNTIME_ARTIFACTS DESTINATION .)
install(FILES TgBot/test.db DESTINATION .)

install(DIRECTORY ${PROJECT_BINARY_DIR}/$<CONFIG>/ DESTINATION . FILES_MATCHING PATTERN "*.dll")
