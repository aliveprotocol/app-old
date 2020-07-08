import QtQuick 2.0
import "../Components"

Item {
    id: element
    property alias getStartedMouseArea: getStartedBtn.btnMouseArea
    Text {
        id: appTitle
        color: "#ffffff"
        text: qsTr("Alive")
        anchors.bottom: appDescription.top
        anchors.bottomMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
        lineHeight: 1
        antialiasing: false
        font.pixelSize: 50
    }

    Text {
        id: appDescription
        color: "#ffffff"
        text: "Decentralized live streaming on DTube chain"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 25
    }

    BigButton {
        id: getStartedBtn
        anchors.top: appDescription.bottom
        anchors.topMargin: 45
        anchors.horizontalCenter: parent.horizontalCenter
        btnLabel: "Get Started"
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.6600000262260437;height:600;width:900}D{i:3;anchors_y:357}
}
##^##*/
