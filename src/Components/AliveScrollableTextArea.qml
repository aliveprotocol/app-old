import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: rectangle
    color: 'transparent'
    border.color: '#ffffff'

    ScrollView {
        id: scrollView
        anchors.fill: parent
        anchors.margins: 1

        TextArea {
            id: textArea
            selectByMouse: true
            background: Rectangle {
                color: 'transparent'
            }
            onActiveFocusChanged: {
                if (textArea.activeFocus)
                    rectangle.border.color = '#ff5555'
                else
                    rectangle.border.color = '#ffffff'
            }
        }
    }
}