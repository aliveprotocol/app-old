import QtQuick 2.15
import QtQuick.Controls 2.15
import "../Components"

Item {
    id: element
    property alias confirmPinBtnMouseArea: confirmPinBtn.btnMouseArea
    property alias newPin: newPinField.text
    property alias confirmPin: confirmPinField.text

    Text {
        id: createPinTitle
        color: "#ffffff"
        text: qsTr("Choose a PIN")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: createPinDescription.top
        anchors.bottomMargin: 30
        font.pixelSize: 50
    }

    Text {
        id: createPinDescription
        width: 736
        height: 48
        color: "#ffffff"
        text: qsTr("Create a PIN number to secure your private keys in the application. PIN numbers must be at least 4 digits long.")
        anchors.bottom: newPinField.top
        anchors.bottomMargin: 70
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignLeft
        wrapMode: Text.WordWrap
        font.pixelSize: 18
    }

    TextField {
        id: newPinField
        width: 347
        height: 26
        readOnly: false
        placeholderText: "New PIN"
        echoMode: TextInput.Password
        inputMethodHints: Qt.ImhDigitsOnly
        validator: RegularExpressionValidator{regularExpression: /[0-9]+/}
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    TextField {
        id: confirmPinField
        width: 347
        height: 26
        placeholderText: "Confirm PIN"
        readOnly: false
        echoMode: TextInput.Password
        inputMethodHints: Qt.ImhDigitsOnly
        validator: RegularExpressionValidator{regularExpression: /[0-9]+/}
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: newPinField.bottom
        anchors.topMargin: 20
    }

    BigButton {
        id: confirmPinBtn
        anchors.top: confirmPinField.bottom
        anchors.topMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
        btnLabel: qsTr("Confirm")
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
