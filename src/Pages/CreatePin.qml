import QtQuick 2.0
import QtQuick.Controls 1.4
import "../Components"

Item {
    property alias confirmPinBtnMouseArea: confirmPinBtn.btnMouseArea
    property alias newPin: newPinField.text
    property alias confirmPin: confirmPinField.text
    width: 900
    height: 600

    Text {
        id: createPinTitle
        x: 306
        y: 80
        color: "#ffffff"
        text: qsTr("Choose a PIN")
        font.pixelSize: 50
    }

    Text {
        id: createPinDescription
        x: 82
        y: 169
        width: 736
        height: 48
        color: "#ffffff"
        text: qsTr("Create a PIN number to secure your private keys in the application. PIN numbers must be at least 4 digits long.")
        horizontalAlignment: Text.AlignLeft
        wrapMode: Text.WordWrap
        font.pixelSize: 18
    }

    TextField {
        id: newPinField
        x: 277
        y: 287
        width: 347
        height: 26
        readOnly: false
        placeholderText: "New PIN"
        textColor: "#000000"
        echoMode: TextInput.Password
        inputMethodHints: Qt.ImhDigitsOnly
        validator: RegExpValidator{regExp: /[0-9]+/}
    }

    TextField {
        id: confirmPinField
        x: 277
        y: 333
        width: 347
        height: 26
        placeholderText: "Confirm PIN"
        readOnly: false
        textColor: "#000000"
        echoMode: TextInput.Password
        inputMethodHints: Qt.ImhDigitsOnly
        validator: RegExpValidator{regExp: /[0-9]+/}
    }

    BigButton {
        id: confirmPinBtn
        x: 388
        y: 400
        btnLabel: qsTr("Confirm")
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
