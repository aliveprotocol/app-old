import QtQuick 2.15
import QtQuick.Controls 2.15
import "../Components"

Item {
    property alias backBtnMouseArea: hiveLoginBackBtn.btnMouseArea
    property alias proceedLoginBtnMouseArea: proceedLoginBtn.btnMouseArea
    property alias hiveUsername: hiveUsernameField.text
    property alias hiveKey: hiveKeyField.text
    property alias remembermeChecked: remembermeSwitch.checked
    onVisibleChanged: {
        if (visible) {
            let settingsJson = {}
            try {
                settingsJson = JSON.parse(userSettingsInstance.readJson())
            } catch (e) {}
            if (settingsJson.hiveAPI)
                loginHiveAPIDropdown.currentIndex = hiveAPIObj.getIndex(settingsJson.hiveAPI)
        }
    }

    RoundedBtn {
        id: hiveLoginBackBtn
        btnLabel: qsTr("<< Back")
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 25
        anchors.leftMargin: 25
    }

    Text {
        id: hiveLoginTitle
        color: "#ffffff"
        text: qsTr("Hive Login")
        anchors.bottom: hiveLoginDescription.top
        anchors.bottomMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 50
    }

    Text {
        id: hiveLoginDescription
        width: 736
        height: 48
        color: "#ffffff"
        text: qsTr("Log in using your Hive username and posting key.")
        anchors.bottom: hiveUsernameField.top
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        font.pixelSize: 18
    }

    AliveTextField {
        id: hiveUsernameField
        width: 347
        height: 26
        placeholderText: "Username"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: hiveKeyField.top
        anchors.bottomMargin: 20
    }

    AliveTextField {
        id: hiveKeyField
        width: 347
        height: 26
        placeholderText: "Posting Key"
        echoMode: TextInput.Password
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 0
    }

    Switch {
        id: remembermeSwitch
        text: qsTr("Remember Me")
        anchors.top: hiveKeyField.bottom
        anchors.topMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
        checked: true

        indicator: Rectangle {
            implicitWidth: 48
            implicitHeight: 26
            x: remembermeSwitch.leftPadding
            y: parent.height / 2 - height / 2
            radius: 13
            color: remembermeSwitch.checked ? "#ff5555" : "#ffffff"
            border.color: remembermeSwitch.checked ? "#ff5555" : "#cccccc"

            Rectangle {
                x: remembermeSwitch.checked ? parent.width - width : 0
                width: 26
                height: 26
                radius: 13
                color: remembermeSwitch.down ? "#cccccc" : "#ffffff"
                border.color: remembermeSwitch.checked ? (remembermeSwitch.down ? "#ff5555" : "#ff4444") : "#999999"
            }
        }

        contentItem: Text {
            text: remembermeSwitch.text
            font: remembermeSwitch.font
            opacity: enabled ? 1.0 : 0.3
            color: "#ffffff"
            verticalAlignment: Text.AlignVCenter
            leftPadding: remembermeSwitch.indicator.width + remembermeSwitch.spacing
        }
    }

    BigButton {
        id: proceedLoginBtn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: remembermeSwitch.bottom
        anchors.topMargin: 35
        btnLabel: qsTr("Login")
    }

    Text {
        id: element
        color: "#ffffff"
        text: qsTr('
            <html>
                <head><style>a {color: #ffffff;} a:hovered {color: #ffffff;} a:visited {color: #ffffff;} a:active { color: #ffffff;}</style></head>
                <body>No account? Get one at <a href="https://signup.hive.io">signup.hive.io</a>.</body>
            </html>')
        textFormat: Text.RichText
        onLinkActivated: (l) => Qt.openUrlExternally(l)
        anchors.top: proceedLoginBtn.bottom
        anchors.topMargin: 35
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 18
    }

    HiveAPI {
        id: hiveAPIObj
    }

    DropdownSelection {
        id: loginHiveAPIDropdown
        height: 25
        width: 347
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        model: hiveAPIObj.apiOptions
        onCurrentIndexChanged: {
            if (userSettingsInstance && userSettingsInstance.get('hiveAPI') !== hiveAPIObj.apiOptions[currentIndex].value && hiveLoginPage.visible) {
                userSettingsInstance.set('hiveAPI',hiveAPIObj.apiOptions[currentIndex].value)
                userSettingsInstance.write()
            }
        }
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.75;height:768;width:1024}
}
##^##*/
