import QtQuick 2.15

Item {
    property alias btnLabel: label.text
    property alias btnMouseArea: mouseArea
    property var selected

    width: 200
    height: 50

    Rectangle {
        id: rectangle
        color: {
            if (mouseArea.containsMouse || selected)
                return "#36393f"
            else
                return "#222222"
        }
        anchors.margins: 0
        anchors.fill: parent

        Text {
            id: label
            x: 30
            y: 15
            width: 162
            height: 20
            color: "#ffffff"
            font.pixelSize: 18
        }
    }

    MouseArea {
        id: mouseArea
        x: 0
        y: 0
        width: 200
        height: 50
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
    }
}
