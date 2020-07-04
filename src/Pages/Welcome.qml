import QtQuick 2.0
import "../Components"

Item {
    property alias getStartedMouseArea: getStartedBtn.btnMouseArea
    Text {
        id: appTitle
        x: 399
        y: 203
        color: "#ffffff"
        text: qsTr("Alive")
        lineHeight: 1
        antialiasing: false
        font.pixelSize: 50
    }

    Text {
        id: appDescription
        x: 213
        y: 285
        color: "#ffffff"
        text: "Decentralized live streaming on DTube chain"
        font.pixelSize: 25
    }

    BigButton {
        id: getStartedBtn
        x: 388
        y: 357
        btnLabel: "Get Started"
    }
}
