import QtQuick 2.15

Item {
    property alias btnLabel: label.text
    property alias btnMouseArea: mouseArea
    property bool disabled: false

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
            anchors.bottomMargin: 6
            anchors.topMargin: 6
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 15
        }
    }

    MouseArea {
        id: mouseArea
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        hoverEnabled: !disabled
        cursorShape: Qt.PointingHandCursor
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:3}
}
##^##*/
