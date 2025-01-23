// CustomTabButton.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    property string tabTitle: ""
    property int tabIndex: -1

    text: tabTitle
    width: 40//parent.width
    height: 40  // Set a height for the button

    background: Rectangle {
        color: "black"//control.pressed ? "lightblue" : "white"
        border.color: "gray"
        radius: 5
    }

    onClicked: {
        // Emit signal when clicked
        buttonClicked(tabIndex)
    }

    signal buttonClicked(int tabIndex)

    // Add padding and margin if necessary
    padding: 10
}
