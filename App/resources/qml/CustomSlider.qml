// CustomSlider.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: customSlider
    width: 200
    height: 40

    property int minimum: 0
    property int maximum: 100
    property int stepSize : 1
    property int value: 50
    property color trackColor: "lightgrey"
    property color progressColor: "dodgerblue"
    property color handleColor: "blue"

    Rectangle {
        id: track
        width: parent.width
        height: 6
        color: trackColor
        anchors.verticalCenter: parent.verticalCenter
        radius: height / 2
    }

    Rectangle {
        id: progress
        width: Math.min(handle.x + handle.width / 2, track.width)
        height: track.height
        color: progressColor
        anchors.verticalCenter: track.verticalCenter
        radius: track.radius
    }

    Rectangle {
        id: handle
        width: 20
        height: 20
        color: handleColor
        radius: width / 2
        anchors.verticalCenter: track.verticalCenter
        x: (value - minimum) / (maximum - minimum) * (track.width - width)

        MouseArea {
            id: dragArea
            anchors.fill: parent
            drag.target: handle

            onPositionChanged: {
                // Calculate new slider value based on handle's position
                const newValue = Math.round((handle.x / (track.width - handle.width)) * (maximum - minimum) + minimum);
                customSlider.value = Math.min(maximum, Math.max(minimum, newValue));
            }
        }
    }

    // Update the handle's position when the value changes
    onValueChanged: {
        console.log((value - minimum) / (maximum - minimum) * (track.width - handle.width))
        handle.x = (value - minimum) / (maximum - minimum) * (track.width - handle.width);
        progress.width = handle.x + handle.width / 2;
    }
}
