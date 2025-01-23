cmake_minimum_required(VERSION 3.5)
project(MyQtApp)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

set(CMAKE_CXX_STANDARD 17)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick Widgets Mqtt)

set(QML_IMPORT_PATH
    # ${CMAKE_CURRENT_SOURCE_DIR}/resources/qml/Components
    ${CMAKE_CURRENT_SOURCE_DIR}/resources/qml
)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

set(SOURCES
    src/main.cpp
    src/Application.cpp
)

set(HEADERS
    src/Application.h
)

set(RESOURCES
    resources/resources.qrc
)

add_executable(MyQtApp ${SOURCES} ${HEADERS} ${RESOURCES}
    src/ParseJson.h src/ParseJson.cpp
    Jsons/config.json)

target_include_directories(MyQtApp PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/../Common)
target_link_libraries(MyQtApp PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Widgets Qt6::Mqtt)
