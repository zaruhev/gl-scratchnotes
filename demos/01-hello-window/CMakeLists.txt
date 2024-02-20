cmake_minimum_required(VERSION 3.20)
project(HelloWindow)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

file(GLOB_RECURSE SOURCES "src/*.cpp")
add_executable(HelloWindow ${SOURCES})

target_include_directories(HelloWindow PRIVATE "${CMAKE_SOURCE_DIR}/../libs/glm")
target_include_directories(HelloWindow PRIVATE "${CMAKE_SOURCE_DIR}/../libs/glfw/include")
target_include_directories(HelloWindow PRIVATE "${CMAKE_SOURCE_DIR}/../libs/glad/include")

target_link_directories(HelloWindow PRIVATE "${CMAKE_SOURCE_DIR}/../build/libs/glad")
target_link_directories(HelloWindow PRIVATE "${CMAKE_SOURCE_DIR}/../build/libs/glfw/src")
target_link_directories(HelloWindow PRIVATE "${CMAKE_SOURCE_DIR}/../build/libs/glm/glm")


target_link_libraries(HelloWindow PRIVATE glm glfw3 glad)