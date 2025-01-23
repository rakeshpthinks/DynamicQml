import QtQuick 2.15
import QtQuick.Layouts 1.15

ColumnLayout {
    id: customColumn
    Layout.fillWidth: true
    anchors.fill: parent
    Layout.fillHeight: true
    // property alias customSpacing: spacing
    property color backgroundColor: "transparent"
    property real borderWidth: 0
    property color borderColor: "transparent"


    Rectangle {
        anchors.fill: parent

        color: customColumn.backgroundColor
        border.color: customColumn.borderColor
        border.width: customColumn.borderWidth
        z: -1
    }
}
