import QtQuick 2.15
import QtQuick.Controls 2.15
import "../Components"

Item {
    property alias backBtnMouseArea: dtcLoginBackBtn.btnMouseArea
    property alias proceedLoginBtnMouseArea: proceedLoginBtn.btnMouseArea
    property alias dtcUsername: dtcUsernameField.text
    property alias dtcKey: dtcKeyField.text

    RoundedBtn {
        id: dtcLoginBackBtn
        btnLabel: qsTr("<< Back")
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 25
        anchors.leftMargin: 25
    }

    Text {
        id: dtcLoginTitle
        color: "#ffffff"
        text: qsTr("Login")
        anchors.bottom: dtcLoginDescription.top
        anchors.bottomMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 50
    }

    Text {
        id: dtcLoginDescription
        width: 736
        height: 48
        color: "#ffffff"
        text: qsTr("Begin by logging into your DTube chain account using your Avalon username and private key. Custom keys must have COMMENT, PUSH_STREAM and END_STREAM permissions.")
        anchors.bottom: dtcUsernameField.top
        anchors.bottomMargin: 70
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignLeft
        wrapMode: Text.WordWrap
        font.pixelSize: 18
    }

    TextField {
        id: dtcUsernameField
        width: 347
        height: 26
        readOnly: false
        placeholderText: "Username"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 0
    }

    TextField {
        id: dtcKeyField
        width: 347
        height: 26
        placeholderText: "Key"
        readOnly: false
        echoMode: TextInput.Password
        anchors.top: dtcUsernameField.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
    }

    BigButton {
        id: proceedLoginBtn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: dtcKeyField.bottom
        anchors.topMargin: 40
        btnLabel: qsTr("Login")
    }

    Text {
        id: element
        color: "#ffffff"
        text: qsTr("No account? Get one at signup.d.tube.")
        anchors.top: proceedLoginBtn.bottom
        anchors.topMargin: 60
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 18
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.75;height:768;width:1024}
}
##^##*/
