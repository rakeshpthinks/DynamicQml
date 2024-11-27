cmake_minimum_required(VERSION 3.16)

project(MyQtApp)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find Qt package
set(Qt6_DIR "/home/ubuntuthinkpad/Rakesh_WorkSpacs/Qt6_Debug/qtBugfix/lib/cmake/Qt6")


add_subdirectory(App)
