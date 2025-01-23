import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
Item {
    id: customTabBar
    width: parent.width
    height: 40
    property int currentIndex: 0
    signal tabIndexChanged(int index)

    RowLayout {
        anchors.fill: parent
        spacing: 10

        Repeater {
            model: customTabBar.children
            delegate: Item {
                width: customTabBar.width / customTabBar.children.length
                height: customTabBar.height

                CustomTabButton {
                    text: modelData.text
                    onClicked: {
                        customTabBar.currentIndex = index
                        customTabBar.tabIndexChanged(index)
                    }
                }
            }
        }
    }
}
