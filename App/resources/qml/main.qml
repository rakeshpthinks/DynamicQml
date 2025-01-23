import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    width: 800
    height: 600
    title: "DynamicUI App"
    visible: true

    ColumnLayout {
        anchors.fill: parent

        TabBar {
            id: tabBar
            Layout.fillWidth: true
            TabButton {
                text: "Slider Tab"
                onClicked: contentStack.currentIndex = 0
            }
            TabButton {
                text: "Progress Tab"
                onClicked: contentStack.currentIndex = 1
            }
            TabButton {
                text: "Input Tab"
                onClicked: contentStack.currentIndex = 2
            }
        }

        StackLayout {
            id: contentStack
            Layout.fillWidth: true
            Layout.fillHeight: true

            Item {
                CustomColumnLayout {
                    Layout.fillHeight: true

                    backgroundColor: "#d0f2ec"
                    borderColor: "black"
                    borderWidth: 2
                    spacing: 20
                    CustomSlider {
                        handleColor: "red"
                        maximum: 100
                        minimum: 0
                        progressColor: "green"
                        stepSize: 5
                        trackColor: "lightgrey"
                        value: 30
                    }
                    Rectangle {
                        color: "blue"
                        height: 100
                        width: 100
                    }
                    Rectangle {
                        color: "blue"
                        height: 100
                        width: 100
                    }
                    CustomSlider {
                        handleColor: "green"
                        maximum: 100
                        minimum: 0
                        progressColor: "blue"
                        stepSize: 5
                        trackColor: "lightgrey"
                        value: 30
                    }
                }
            }
            Item {
                CustomRowLayout {
                    Layout.fillHeight: true

                    backgroundColor: "#e0e0e0"
                    borderColor: "gray"
                    borderWidth: 1
                    spacing: 15
                    CustomProgressBar {
                        maximumValue: 100
                        minimumValue: 0
                        progressColor: "blue"
                        trackColor: "gray"
                        value: 70
                    }
                    Switch {
                        checked: true
                    }
                }
            }
            Item {
                CustomGridLayout {
                    Layout.fillHeight: true

                    backgroundColor: "#dff2ff"
                    borderColor: "blue"
                    borderWidth: 3
                    columnSpacing: 5
                    columns: 2
                    rowSpacing: 10
                    Rectangle {
                        color: "blue"
                        height: 300
                        width: 300
                    }
                    Rectangle {
                        color: "green"
                        height: 300
                        width: 300
                    }
                    Rectangle {
                        color: "red"
                        height: 300
                        width: 300
                    }
                }
            }
        }
    }
}
