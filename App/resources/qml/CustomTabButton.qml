import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: customTabButton
    width: 100
    height: 40
    text: "Tab"

    // Customize the appearance
    background: Rectangle {
        implicitWidth: customTabButton.width
        implicitHeight: customTabButton.height
        border.color: "#4682B4" // SteelBlue border
        radius: 10

        gradient: Gradient {
            id: buttonGradient
            GradientStop { position: 0.0; color: customTabButton.down ? "#1E90FF" : "#B0E0E6" } // Lighter color at the top
            GradientStop { position: 1.0; color: customTabButton.down ? "#1E90FF" : "#87CEFA" } // Darker color at the bottom
        }
    }

    // Add hover effect
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onEntered: {
            buttonGradient.stops[0].color = "#ADD8E6"; // LightBlue when hovered
            buttonGradient.stops[1].color = "#87CEFA"; // LightSkyBlue when hovered
        }

        onExited: {
            buttonGradient.stops[0].color = customTabButton.down ? "#1E90FF" : "#B0E0E6"; // Reset color when not hovered
            buttonGradient.stops[1].color = customTabButton.down ? "#1E90FF" : "#87CEFA"; // Reset color when not hovered
        }
    }

    // Customize the text
    font.pixelSize: 16
    font.bold: true
    // color: "white"
}
