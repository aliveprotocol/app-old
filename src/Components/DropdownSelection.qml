import QtQuick 2.15
import QtQuick.Controls 2.15

ComboBox {
    id: comboBox
    displayText: comboBox.model[currentIndex].text

    delegate: ItemDelegate {
        id: itemDelegate
        width: comboBox.width
        contentItem: Text {
            text: modelData.text
            color: "#ffffff"
            font: comboBox.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        highlighted: comboBox.highlightedIndex == index
        background: Rectangle {
            color: itemDelegate.highlighted ? "#ff5555" : "#000000"
        }
    }

    indicator: Canvas {
        id: canvas
        x: comboBox.width - width - comboBox.rightPadding
        y: comboBox.topPadding + (comboBox.availableHeight - height) / 2
        width: 12
        height: 8
        contextType: "2d"

        Connections {
            target: comboBox
            function onPressedChanged() { canvas.requestPaint(); }
        }

        onPaint: {
            context.reset();
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fillStyle = comboBox.pressed ? "#ff5555" : "#ffffff";
            context.fill();
        }
    }

    contentItem: Text {
        leftPadding: 0
        rightPadding: comboBox.indicator.width + comboBox.spacing

        text: comboBox.displayText
        font: comboBox.font
        color: "#ffffff"
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 120
        implicitHeight: 40
        color: 'transparent'
        border.color: comboBox.popup.visible ? "#ff5555" : "#ffffff"
        border.width: comboBox.visualFocus ? 2 : 1
    }

    popup: Popup {
        y: comboBox.height - 1
        width: comboBox.width
        implicitHeight: contentItem.implicitHeight
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: comboBox.popup.visible ? comboBox.delegateModel : null
            currentIndex: comboBox.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            border.color: "#ffffff"
        }
    }
}
