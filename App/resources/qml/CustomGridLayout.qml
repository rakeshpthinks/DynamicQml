import QtQuick 2.15
import QtQuick.Layouts 1.15

GridLayout {
    id: customGrid
    Layout.fillWidth: true
    Layout.fillHeight: true
    anchors.fill: parent
    // property alias customRowSpacing: rowSpacing
    // property alias customColumnSpacing: columnSpacing
    // property alias customColumns: columns
    property color backgroundColor: "transparent"
    property real borderWidth: 0
    property color borderColor: "transparent"

    // Rectangle {
    //     anchors.fill: parent
    //     color: customGrid.backgroundColor
    //     border.color: customGrid.borderColor
    //     border.width: customGrid.borderWidth
    //     z: -1
    // }
}
