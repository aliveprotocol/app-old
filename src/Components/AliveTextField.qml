import QtQuick
import QtQuick.Controls

TextField {
    id: textField
    selectByMouse: true
    background: textFieldBackground
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
