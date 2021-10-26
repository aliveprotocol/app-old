import QtQuick 2.15

Item {
    property alias fieldLabel: titleLbl.text
    property alias fieldPlaceholder: titleField.placeholderText
    property alias fieldValue: titleField.text
    height: 47

    Text {
        id: titleLbl
        height: 22
        color: "#ffffff"
        anchors.leftMargin: 0
        anchors.topMargin: 0
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 18
    }

    AliveTextField {
        id: titleField
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: titleLbl.bottom
        anchors.topMargin: 5
        height: 25
    }
}
