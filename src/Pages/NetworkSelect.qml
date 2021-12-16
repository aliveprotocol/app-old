import QtQuick 2.15
import "../Components"

Item {
    id: element
    property alias networkSelectBackMouseArea: networkSelectBackBtn.btnMouseArea
    property alias networkSelectAvalonMouseArea: networkSelectAvalon.btnMouseArea
    property alias networkSelectHiveMouseArea: networkSelectHive.btnMouseArea

    RoundedBtn {
        id: networkSelectBackBtn
        btnLabel: qsTr("<< Back")
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 25
        anchors.leftMargin: 25
    }

    Text {
        id: networkSelectTitle
        color: "#ffffff"
        text: qsTr("Let's Begin")
        anchors.bottom: networkSelectDescription.top
        anchors.bottomMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
        lineHeight: 1
        antialiasing: false
        font.pixelSize: 50
    }

    Text {
        id: networkSelectDescription
        height: 75
        color: "#ffffff"
        text: "Alive supports streaming to both Hive and Avalon networks. Select a network to begin. You can always authenticate to additional networks later."
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 30
        anchors.rightMargin: 30
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        clip: false
    }

    // TODO: Organize into ListView if we add support for BLURT network
    BigButton {
        id: networkSelectAvalon
        width: 125
        anchors.top: networkSelectDescription.bottom
        anchors.horizontalCenterOffset: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 40
        btnLabel: "Avalon"
    }

    BigButton {
        id: networkSelectHive
        x: 152
        width: 125
        anchors.top: networkSelectDescription.bottom
        anchors.horizontalCenterOffset: -100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 40
        btnLabel: "Hive"
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:3}D{i:4}
}
##^##*/
