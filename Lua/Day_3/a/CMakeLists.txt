cmake_minimum_required(VERSION 3.5)

project(play LANGUAGES CXX)

find_package(Lua REQUIRED)

add_executable(play play.cpp)

target_include_directories(play PRIVATE ${LUA_INCLUDE_DIR})
target_link_libraries(play PRIVATE ${LUA_LIBRARIES})
