import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    width: 800
    height: 600
    title: "Dynamic Application"
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
            ColumnLayout {
                spacing: 10
                    CustomSlider {
                        handleColor: "red"
                        maximum: 100
                        minimum: 0
                        progressColor: "green"
                        stepSize: 5
                        trackColor: "lightgrey"
                        value: 30
                    }
                    Text {
                        color: "blue"
                        font.pixelSize: 16
                        text: "Slider Value"
                    }
                }
            }
            Item {
            RowLayout {
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
            GridLayout {
                columnSpacing: 15
                columns: 2
                rowSpacing: 10
                    TextField {
                        placeholderText: "Enter your name"
                        width: 200
                    }
                    Button {
                        text: "Submit"
                    }
                }
            }
        }
    }
}
