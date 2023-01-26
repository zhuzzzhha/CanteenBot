cmake_minimum_required(VERSION 3.14)
#cmake_policy(SET CMP0074 OLD)

##########################################################
project(course_test)			# Название проекта

#########################################################
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall")

##########################################################
set(Boost_USE_STATIC_LIBS       ON)   # only find static libs
set(Boost_USE_MULTITHREADED     ON)
SET(CURL_STATICLIB ON)
Set(CURL_NO_CURL_CMAKE ON)
set(OpenSSL_USE_STATIC_LIBS ON)
##########################################################
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_BINARY_DIR}/install" CACHE PATH "..." FORCE)
endif()

SET(CMAKE_LIBRARY_PATH ${PROJECT_SOURCE_DIR}/lib)

set(SQLite3_INCLUDE_DIR ${PROJECT_SOURCE_DIR}/lib)

find_package(SQLite3)
if(NOT SQLite3_FOUND)
	message(SEND_ERROR "Failed to find SQLite3.")
	return()
else()
	message(STATUS "SQLite3 library: ${SQLite3_LIBRARIES}") 
	include_directories(${SQLite3_INCLUDE_DIRS})
endif()
##########################################################
set(ZLIB_ROOT ${PROJECT_SOURCE_DIR}/lib)

find_package(ZLIB)
if(NOT ZLIB_FOUND)
	message(SEND_ERROR "Failed to find ZLIB.")
	return()
else()
     message(STATUS "ZLIB library: ${ZLIB_LIBRARIES}") 
  include_directories(${ZLIB_INCLUDE_DIRS})
endif()
##########################################################
set(OPENSSL_ROOT_DIR ${PROJECT_SOURCE_DIR}/lib)
set(OPENSSL_INCLUDE_DIR ${PROJECT_SOURCE_DIR}/lib)

find_package(OpenSSL)
if (NOT OPENSSL_FOUND)
	message(SEND_ERROR "Failed to find OpenSSL.")
	return()
else()
     message(STATUS "OpenSSL library: ${OPENSSL_CRYPTO_LIBRARY}") 
  include_directories(${OPENSSL_INCLUDE_DIR})
endif()
##########################################################
set(CURL_LIBRARY ${PROJECT_SOURCE_DIR}/lib)
set(CURL_INCLUDE_DIRS ${PROJECT_SOURCE_DIR}/lib)

find_package(CURL)
 IF(NOT CURL_FOUND)
 	message(SEND_ERROR "Failed to find CURL.")
	return()
else()
     message(STATUS "CURL library: ${CURL_LIBRARIES}") 
  include_directories(${CURL_INCLUDE_DIRS})
endif()
##########################################################
set(Boost_INCLUDE_DIRS ${Boost_INCLUDE_DIR})

if(Boost_LIBRARY_DIR_RELEASE)
  list(APPEND Boost_LIBRARY_DIRS ${Boost_LIBRARY_DIR_RELEASE})
endif()

find_package (Boost COMPONENTS system REQUIRED)
if(NOT Boost_FOUND)
	message(SEND_ERROR "Failed to find Boost.")
	return()
else()
	add_definitions(-DBOOST_THREAD_USE_LIB)
	include_directories(${Boost_LIBRARY_DIRS})
	include_directories(SYSTEM ${Boost_INCLUDE_DIRS})
endif()

#########################################

include(FetchContent)
FetchContent_Declare(tgbot-cpp
GIT_REPOSITORY https://github.com/reo7sp/tgbot-cpp
GIT_TAG origin/master)
FetchContent_GetProperties(tgbot-cpp)

if(NOT tgbot-cpp_POPULATED)
FetchContent_Populate(tgbot-cpp)
FetchContent_MakeAvailable(tgbot-cpp)

# copy db-file
file(COPY ${PROJECT_SOURCE_DIR}/TgBot/test.db DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
file(COPY ${PROJECT_SOURCE_DIR}/TgBot/test.db DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/Debug)

# copy required dlls
file(COPY ${PROJECT_SOURCE_DIR}/lib/sqlite3.dll DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/Debug)
file(COPY ${PROJECT_SOURCE_DIR}/lib/libssl-1_1-x64.dll DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/Debug)
file(COPY ${PROJECT_SOURCE_DIR}/lib/libcrypto-1_1-x64.dll DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/Debug)


add_subdirectory(${tgbot-cpp_SOURCE_DIR} ${tgbot-cpp_BINARY_DIR} EXCLUDE_FROM_ALL)
endif()
##########################################################
add_executable(course_test TgBot/src/source.cpp)
##########################################################
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
install(TARGETS course_test DESTINATION .)
install(FILES TgBot/test.db DESTINATION .)
target_link_libraries(course_test PUBLIC TgBot ${CMAKE_THREAD_LIBS_INIT} ${Boost_LIBRARIES} ${SQLite3_LIBRARIES} ${ZLIB_LIBRARIES} ${OPENSSL_CRYPTO_LIBRARY} ${CURL_LIBRARIES})

