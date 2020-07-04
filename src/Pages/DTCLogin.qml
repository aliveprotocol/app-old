import QtQuick 2.0
import QtQuick.Controls 1.4
import "../Components"

Item {
    property alias proceedLoginBtnMouseArea: proceedLoginBtn.btnMouseArea
    property alias dtcUsername: dtcUsernameField.text
    property alias dtcKey: dtcKeyField.text
    width: 900
    height: 600

    Text {
        id: dtcLoginTitle
        x: 391
        y: 80
        color: "#ffffff"
        text: qsTr("Login")
        font.pixelSize: 50
    }

    Text {
        id: dtcLoginDescription
        x: 82
        y: 169
        width: 736
        height: 48
        color: "#ffffff"
        text: qsTr("Begin by logging into your DTube chain account using your Avalon username and private key. Custom keys must have COMMENT, PUSH_STREAM and END_STREAM permissions.")
        horizontalAlignment: Text.AlignLeft
        wrapMode: Text.WordWrap
        font.pixelSize: 18
    }

    TextField {
        id: dtcUsernameField
        x: 277
        y: 287
        width: 347
        height: 26
        readOnly: false
        placeholderText: "Username"
        textColor: "#000000"
    }

    TextField {
        id: dtcKeyField
        x: 277
        y: 333
        width: 347
        height: 26
        placeholderText: "Key"
        readOnly: false
        textColor: "#000000"
        echoMode: TextInput.Password
    }

    BigButton {
        id: proceedLoginBtn
        x: 388
        y: 400
        btnLabel: qsTr("Login")
    }

    Text {
        id: element
        x: 295
        y: 510
        color: "#ffffff"
        text: qsTr("No account? Get one at signup.d.tube.")
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 18
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}
}
##^##*/
