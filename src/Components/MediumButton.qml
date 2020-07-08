import QtQuick 2.0

Item {
    property alias btnLabel: label.text
    property alias btnMouseArea: mouseArea
    width: 80
    height: 30

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
        border.width: 1
        border.color: "#ffffff"

        Text {
            id: label
            color: {
                if (mouseArea.containsMouse)
                    return "#36393f"
                else
                    return "#ffffff"
            }
            anchors.rightMargin: 6
            anchors.leftMargin: 6
            anchors.bottomMargin: 4
            anchors.topMargin: 4
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 15
        }
    }

    MouseArea {
        id: mouseArea
        x: 0
        y: 0
        width: 60
        height: 30
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:3}
}
##^##*/
