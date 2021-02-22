import QtQuick 2.15

Item {
    property alias btnLabel: label.text
    property alias btnMouseArea: mouseArea
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
        anchors.margins: 0
        anchors.fill: parent
        border.width: 2
        border.color: "#ffffff"

        Text {
            id: label
            x: 8
            y: 15
            width: 109
            height: 20
            color: {
                if (mouseArea.containsMouse)
                    return "#36393f"
                else
                    return "#ffffff"
            }
            horizontalAlignment: Text.AlignHCenter
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

/*##^##
Designer {
    D{i:0;formeditorZoom:3}
}
##^##*/
