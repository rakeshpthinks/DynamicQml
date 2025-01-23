import QtQuick 2.15
import QtQuick.Layouts 1.15

RowLayout {

    id: customRow
    Layout.fillWidth: true
    Layout.fillHeight: true
    anchors.fill: parent

    // property alias customSpacing: spacing
    property color backgroundColor: "transparent"
    property real borderWidth: 0
    property color borderColor: "transparent"

    Rectangle {
        anchors.fill: parent
        color: customRow.backgroundColor
        border.color: customRow.borderColor
        border.width: customRow.borderWidth
        z: -1
    }
}
