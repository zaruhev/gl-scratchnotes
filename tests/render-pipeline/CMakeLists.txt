cmake_minimum_required(VERSION 3.20) 
project("Pipeline") 
 
set(CMAKE_CXX_STANDARD 20) 
set(CMAKE_CXX_STANDARD_REQUIRED ON) 
 
file(GLOB_RECURSE SOURCES "src/*.cpp") 
add_executable("Pipeline" ${SOURCES}) 
target_include_directories("Pipeline" PRIVATE "C:/Users/Sarah/repos/graphics/gl-scratchnotes//libs/glm") 
target_include_directories("Pipeline" PRIVATE "C:/Users/Sarah/repos/graphics/gl-scratchnotes//libs/glfw/include") 
target_include_directories("Pipeline" PRIVATE "C:/Users/Sarah/repos/graphics/gl-scratchnotes//libs/glad/include") 
 
target_link_directories("Pipeline" PRIVATE "C:/Users/Sarah/repos/graphics/gl-scratchnotes//build/libs/glad") 
target_link_directories("Pipeline" PRIVATE "C:/Users/Sarah/repos/graphics/gl-scratchnotes//build/libs/glfw/src") 
target_link_directories("Pipeline" PRIVATE "C:/Users/Sarah/repos/graphics/gl-scratchnotes//build/libs/glm/glm") 
 
target_link_libraries("Pipeline" PRIVATE glm glfw3 glad) 
