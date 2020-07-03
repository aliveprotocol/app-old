import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    title: qsTr("Alive")
    width: 900
    height: 600
    minimumWidth: 900
    minimumHeight: 600
    maximumWidth: 900
    maximumHeight: 600
    color: "#36393f"
    visible: true

    Text {
        id: element
        x: 399
        y: 203
        color: "#ffffff"
        text: qsTr("Alive")
        lineHeight: 1
        antialiasing: false
        font.pixelSize: 50
    }

    Text {
        id: element1
        x: 213
        y: 285
        color: "#ffffff"
        text: "Decentralized live streaming on DTube chain"
        font.pixelSize: 25
    }

    Button1 {
        id: button1
        x: 388
        y: 357
    }
}




/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}
}
##^##*/
