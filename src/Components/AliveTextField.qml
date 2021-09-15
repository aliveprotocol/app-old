import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
    id: textField
    selectByMouse: true
    background: textFieldBackground
    font.pixelSize: 14
    onFocusChanged: {
        if (textField.focus)
            textFieldBackground.border.color = '#ff5555'
        else
            textFieldBackground.border.color = '#ffffff'
    }

    // background of textField
    Rectangle {
        id: textFieldBackground
        anchors.margins: 0
        border.color: '#ffffff'
        color: 'transparent'
    }

}
