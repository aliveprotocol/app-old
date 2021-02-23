import QtQuick 2.15

Item {
    property alias btnLabel: label.text
    property alias btnMouseArea: mouseArea
    width: 100
    height: 30

    Rectangle {
        id: rectangle
        color: {
            if (mouseArea.containsMouse)
                return "#ffffff"
            else
                return "#36393f"
        }
        radius: 15
        anchors.margins: 0
        anchors.fill: parent
        border.width: 2
        border.color: "#ffffff"

        Text {
            id: label
            color: {
                if (mouseArea.containsMouse)
                    return "#36393f"
                else
                    return "#ffffff"
            }
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            minimumPointSize: 10
            minimumPixelSize: 10
            font.pixelSize: 12
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:3}D{i:2}D{i:3}
}
##^##*/
