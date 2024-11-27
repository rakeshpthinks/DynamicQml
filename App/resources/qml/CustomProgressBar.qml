// CustomProgressBar.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: customProgressBar
    width: 200
    height: 20
    property int minimumValue: 0
    property int maximumValue: 100
    property int value: 0
    property color progressColor: "dodgerblue"
    property color trackColor: "lightgrey"
    signal progressValueChanged(int newValue)

    // Calculate progress width based on the current value
    property real progressWidth: (value - minimumValue) / (maximumValue - minimumValue) * width

    // Background bar
    Rectangle {
        id: backgroundBar
        anchors.fill: parent
        color: trackColor
        radius: 10
    }

    // Foreground progress bar
    Rectangle {
        id: foregroundBar
        width: customProgressBar.progressWidth
        height: parent.height
        color: progressColor
        radius: 10
    }

    // Optional: Display progress percentage text
    Text {
        anchors.centerIn: parent
        text: Math.round((value - minimumValue) / (maximumValue - minimumValue) * 100) + "%"
        color: "white"
        font.bold: true
    }

    // Emit custom signal when value changes
    onValueChanged: {
        foregroundBar.width = progressWidth
        progressValueChanged(value)
    }
}
