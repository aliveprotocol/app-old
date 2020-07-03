import QtQuick 2.0

Item {
    width: 125
    height: 50

    Rectangle {
        id: rectangle
        color: {
            if (mouseArea.containsMouse)
                return "#ffffff"
            else
                return "#36393f"
        }
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent
        border.width: 2
        border.color: "#ffffff"

        Text {
            id: element
            x: 19
            y: 15
            color: {
                if (mouseArea.containsMouse)
                    return "#36393f"
                else
                    return "#ffffff"
            }
            text: "Get Started"
            font.pixelSize: 17
        }
    }

    MouseArea {
        id: mouseArea
        x: 0
        y: 0
        width: 125
        height: 50
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
    }
}
