// CustomTabLayout.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
Item {
    property alias currentIndex: contentStack.currentIndex
    property var tabsData  // This will be the data for the tabs

    StackLayout {
        id: contentStack
        Layout.fillWidth: true
        Layout.fillHeight: true

        // Dynamically generate content for each tab based on `tabsData`
        Repeater {
            model: tabsData

            Item {
                // Add content specific to each tab
                // For example, you can call a function to render layout
                Rectangle {
                    width: parent.width
                    height: 300
                    color: "lightblue"
                    Text {
                        anchors.centerIn: parent
                        text: modelData.title
                    }
                }
            }
        }
    }

    // Define a signal that will be triggered when a tab is clicked
    signal tabClicked(int index)
}
